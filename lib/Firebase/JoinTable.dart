import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quanlysanbong/Firebase/BangGiaSan_Data.dart';
import 'package:quanlysanbong/Firebase/ChiTietSan.dart';
import 'package:quanlysanbong/Firebase/DatSan_Data.dart';
import 'package:quanlysanbong/Firebase/San_Data.dart';
import 'package:quanlysanbong/Firebase/TaiKhoan_Data.dart';


class JoinTable {

  static Stream<List<Map<dynamic, dynamic>>> TaiKhoanFromMaTK(
      String maTK) async* {
    var db = FirebaseFirestore.instance;

    var collection = db.collectionGroup('TaiKhoan').where(
        'MaTK', isEqualTo: maTK);
    var snapshot = await collection.get();

    var results = <Map<dynamic, dynamic>>[];

    for (var doc in snapshot.docs) {
      var taiKhoan = TaiKhoan.fromJson(doc.data()!);
      var data = {
        ...taiKhoan.toJson(),
      };
      results.add(data);
    }
    yield results;
  }

  // static Future<double> tinhTienSan(String maTK, String maSan, int gioBatDau, int gioKetThuc ) async {
  //   var db = FirebaseFirestore.instance;
  //   double tongTien = 0;
  //   for(int i = gioBatDau; i < gioKetThuc; i++){
  //     var bangGiaSanSnapshot = await db.collection('BangGiaSan')
  //         .where('MaSan', isEqualTo: maSan)
  //         .where('Gio', isEqualTo: i)
  //         .get();
  //     var bangGiaSan = BangGiaSan.fromJson(bangGiaSanSnapshot.docs.first.data()!);
  //     tongTien += double.parse(bangGiaSan.GiaTheoGio.toString());
  //   }
  //   var taiKhoanSnapshot = await db.collection('TaiKhoan')
  //       .where('MaTK', isEqualTo: maTK)
  //       .get();
  //   var taiKhoan = TaiKhoan.fromJson(taiKhoanSnapshot.docs.first.data()!);
  //
  //   if(taiKhoan.Vip == true){
  //     return tongTien - tongTien * 0.05;
  //     print(tongTien - tongTien * 0.05);
  //   }
  //
  //   else{
  //     return tongTien;
  //     print(tongTien);
  //   }
  // }
  static Stream<List<Map<dynamic, dynamic>>> tinhTienSan(String maTK, String maSan, int gioBatDau, int gioKetThuc ) async* {
    var db = FirebaseFirestore.instance;
    var results = <Map<dynamic, dynamic>>[];
    double tongTien = 0;
    for(int i = gioBatDau; i < gioKetThuc; i++){
      var bangGiaSanSnapshot = await db.collection('BangGiaSan')
          .where('MaSan', isEqualTo: maSan)
          .where('Gio', isEqualTo: i)
          .get();
      var bangGiaSan = BangGiaSan.fromJson(bangGiaSanSnapshot.docs.first.data()!);
      tongTien += double.parse(bangGiaSan.GiaTheoGio.toString());
    }
    var taiKhoanSnapshot = await db.collection('TaiKhoan')
        .where('MaTK', isEqualTo: maTK)
        .get();
    var taiKhoan = TaiKhoan.fromJson(taiKhoanSnapshot.docs.first.data()!);

    if(taiKhoan.Vip == true){
      tongTien =  tongTien - tongTien * 0.05;
      var data = {
        'TongTien' : tongTien,
      };
      results.add(data);
      print(results);
    }
    else{
      var data = {
        'TongTien' : tongTien,
      };
      results.add(data);
      print(results);
    }
    yield results;
  }

  static Stream<List<Map<dynamic, dynamic>>> getTinhTrangSanCon(String maSan,String ngayDat, int gioDat) async* {
    var db = FirebaseFirestore.instance;
    var results = <Map<dynamic, dynamic>>[];
    var sanConDaDuocDats = <String>[];

    var sanSnapshot = await db.collection('San')
        .where('MaSan', isEqualTo: maSan)
        .get();

    var datSanSnapshot = await db.collection('DatSan')
        .where('MaSan', isEqualTo: maSan)
        .where('NgayDenSan', isEqualTo: ngayDat)
        .where('GioBatDau', isEqualTo: gioDat)
        .where('MaTK', isEqualTo: "HideBooking")
        .get();

    var san = San.fromJson(sanSnapshot.docs.first.data()!);

    if (datSanSnapshot.docs.isNotEmpty) {
      for (var datSanDoc in datSanSnapshot.docs) {
        var datSan = DatSan.fromJson(datSanDoc.data()!);

        for (var sancon in san.SanCons!) {
          if (sancon == datSan.ViTriSan) {
            sanConDaDuocDats.add(sancon);
            var data = {
              'TenSan': san.TenSan,
              'TenSanCon': sancon,
              'TinhTrang': 'Đang được đặt',
            };
            results.add(data);
          }
        }
      }
      for (var sancon in san.SanCons!) {
        if (!sanConDaDuocDats.contains(sancon)) {
          var data = {
            'TenSan': san.TenSan,
            'TenSanCon': sancon,
            'TinhTrang': 'Còn Trống',
          };
          results.add(data);
        }
      }
    } else {
      for (var sancon in san.SanCons!) {
        var data = {
          'TenSan': san.TenSan,
          'TenSanCon': sancon,
          'TinhTrang': 'Còn Trống',
        };
        results.add(data);
      }
    }
    yield results;
  }

  static Stream<List<Map<dynamic, dynamic>>> joinDatSan_San(
      String maTK) async* {
    var db = FirebaseFirestore.instance;

    var collection = db.collectionGroup('DatSan').
    where('MaTK', isEqualTo: maTK);
    var snapshot = await collection.get();

    var results = <Map<dynamic, dynamic>>[];

    for (var doc in snapshot.docs) {
      var datSan = DatSan.fromJson(doc.data()!);

      var querySnapshotSan = await db
          .collectionGroup('San')
          .where('MaSan', isEqualTo: datSan.MaSan)
          .where('SanCons', arrayContainsAny: [datSan.ViTriSan])
          .get();

      for (var queryDoc in querySnapshotSan.docs) {
        var san = San.fromJson(queryDoc.data()!);

        var data = {
          ...san.toJson(),
          ...datSan.toJson(),
        };
        results.add(data);
      }
    }
    yield results;
  }

  // static Stream<List<Map<dynamic, dynamic>>> getTinhTrangSanCon(String maSan,String ngayDat, int gioDat) async* {
  //   var db = FirebaseFirestore.instance;
  //   var results = <Map<dynamic, dynamic>>[];
  //   var sanConDaDuocDats = <String>[];
  //   int soSanConConLai;
  //
  //   var sanSnapshot = await db.collection('San')
  //       .where('MaSan', isEqualTo: maSan)
  //       .get();
  //
  //   var datSanSnapshot = await db.collection('DatSan')
  //       .where('MaSan', isEqualTo: maSan)
  //       .where('NgayDenSan', isEqualTo: ngayDat)
  //       .where('GioBatDau', isEqualTo: gioDat)
  //       .get();
  //
  //   var san = San.fromJson(sanSnapshot.docs.first.data()!);
  //   if (datSanSnapshot.docs.isNotEmpty) {
  //     for (var datSanDoc in datSanSnapshot.docs) {
  //       var datSan = DatSan.fromJson(datSanDoc.data()!);
  //
  //       for (var sancon in san.SanCons!) {
  //         if (sancon == datSan.ViTriSan) {
  //           var data = {
  //             'TenSan': san.TenSan,
  //             'TenSanCon': sancon,
  //             'TinhTrang': 'Đang được đặt',
  //           };
  //           results.add(data);
  //         } else {
  //           var data = {
  //             'TenSan': san.TenSan,
  //             'TenSanCon': sancon,
  //             'TinhTrang': 'Còn Trống',
  //           };
  //           results.add(data);
  //         }
  //       }
  //     }
  //   } else {
  //     for (var sancon in san.SanCons!) {
  //       var data = {
  //         'TenSan': san.TenSan,
  //         'TenSanCon': sancon,
  //         'TinhTrang': 'Còn Trống',
  //       };
  //       results.add(data);
  //     }
  //   }
  //   yield results;
  // }

  static Stream<List<Map<String, dynamic>>> joinTables() {
    final streamController = StreamController<List<Map<String, dynamic>>>();

    FirebaseFirestore.instance.collection('ChiTietSan').snapshots().listen((
        chiTietSanSnapshot) async {
      final joinedData = <Map<String, dynamic>>[];

      for (final chiTietSanDoc in chiTietSanSnapshot.docs) {
        final chiTietSanData = chiTietSanDoc.data();
        final maSan = chiTietSanData['MaSan'];

        final sanSnapshot = await FirebaseFirestore.instance.collection('San')
            .where('MaSan', isEqualTo: maSan).limit(1)
            .get();

        if (sanSnapshot.docs.isNotEmpty) {
          final sanData = sanSnapshot.docs.first.data();
          final maCTS = chiTietSanData['MaCTS'];

          final datSanSnapshot = await FirebaseFirestore.instance.collection(
              'DatSan').where('MaCTS', isEqualTo: maCTS).limit(1).get();

          if (datSanSnapshot.docs.isNotEmpty) {
            final datSanData = datSanSnapshot.docs.first.data();

            final joinedRow = {
              'MaCTS': maCTS,
              'MaSan': maSan,
              'MaDS': datSanData['MaDS'],
              'TenSan': sanData['TenSan'],
              'SoSan': chiTietSanData['SoSan'],
              // Các trường dữ liệu khác bạn muốn lấy từ các bảng
            };
            joinedData.add(joinedRow);
          }
        }
      }

      streamController.add(joinedData);
    });

    return streamController.stream;
  }
}
