import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quanlysanbong/Firebase/ChiTietSan.dart';
import 'package:quanlysanbong/Firebase/DatSan_Data.dart';
import 'package:quanlysanbong/Firebase/San_Data.dart';


class JoinTable {
  static Stream<List<dynamic>> joinChiTietSanAndDatSan() async* {
    var datSanCollection = FirebaseFirestore.instance.collection('DatSan');
    var chitietSanCollection = FirebaseFirestore.instance.collection(
        'ChiTietSan');

    var snapshots = await FirebaseFirestore.instance.collectionGroup(
        'ChiTietSan').get();
    var chiTietSanList = snapshots.docs.map((doc) =>
        ChiTietSan.fromJson(doc.data())).toList();

    snapshots =
    await FirebaseFirestore.instance.collectionGroup('DatSan').get();
    var datSanList = snapshots.docs.map((doc) => DatSan.fromJson(doc.data()))
        .toList();

    var joinList = <Map<String, dynamic>>[];

    for (var chiTietSan in chiTietSanList) {
      var datSanDocs = await datSanCollection.where(
          'MaCTS', isEqualTo: chiTietSan.MaCTS).get();
      datSanDocs.docs.forEach((doc) {
        joinList.add({...chiTietSan.toJson(), ...doc.data()});
      });
    }

    yield joinList;
  }


  static Stream<List<Map<dynamic, dynamic>>> joinChiTietSanVaDatSan() async* {
    var db = FirebaseFirestore.instance;

    var collection = db.collectionGroup('ChiTietSan');
    var snapshot = await collection.get();

    var results = <Map<dynamic, dynamic>>[];

    for (var doc in snapshot.docs) {
      var chiTietSan = ChiTietSan.fromJson(doc.data()!);

      var querySnapshotDS = await db
          .collectionGroup('DatSan')
          .where('MaCTS', isEqualTo: chiTietSan.MaCTS)
          .get();


      for (var queryDoc in querySnapshotDS.docs) {
        var datSan = DatSan.fromJson(queryDoc.data()!);

        var data = {
          ...chiTietSan.toJson(),
          ...datSan.toJson(),
        };
        print(data);

        results.add(data);
      }
    }
    yield results;
  }


  static Stream<List<Map<dynamic, dynamic>>> joinDatSan_San(
      String maTK) async* {
    var db = FirebaseFirestore.instance;

    var collection = db.collectionGroup('DatSan').where(
        'MaTK', isEqualTo: maTK);
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

  static Stream<List<Map<dynamic, dynamic>>> getTinhTrangSanCon(String maSan,
      String ngayDat, int gioDat) async* {
    var db = FirebaseFirestore.instance;
    var datSanSnapshot = await db.collection('DatSan')
        .where('MaSan', isEqualTo: maSan)
        .where('NgayDenSan', isEqualTo: ngayDat)
        .where('GioBatDau', isEqualTo: gioDat)
        .get();


    var results = <Map<dynamic, dynamic>>[];

    for (var datSanDoc in datSanSnapshot.docs) {
      var datSan = DatSan.fromJson(datSanDoc.data()!);

      var sanSnapshot = await db
          .collection('San')
          .where('MaSan', isEqualTo: maSan)
          .get();

      var san = San.fromJson(sanSnapshot.docs.first.data()!);
      if (datSanSnapshot.docs.isNotEmpty) {
        for (var sancon in san.SanCons!) {
          if (sancon == datSan.ViTriSan) {
            var data = {
              'TenSan': san.TenSan,
              'TenSanCon': sancon,
              'TinhTrang': 'đã đặt',
            };
            results.add(data);
          } else {
            var data = {
              'TenSan': san.TenSan,
              'TenSanCon': sancon,
              'TinhTrang': 'còn trống',
            };
            results.add(data);
          }
        }
      }
      if (datSanSnapshot.docs.isEmpty) {
        for (var sancon in san.SanCons!) {
          var data = {
            'TenSan': san.TenSan,
            'TenSanCon': sancon,
            'TinhTrang': 'còn trống',
          };
          results.add(data);
        }
      }
    }
    yield results;
  }

  static Stream<List<Map<dynamic, dynamic>>> getTinhTrangSanCon2(String maSan,String ngayDat, int gioDat) async* {
    var db = FirebaseFirestore.instance;
    var results = <Map<dynamic, dynamic>>[];

    var sanSnapshot = await db.collection('San')
        .where('MaSan', isEqualTo: maSan)
        .get();

    var datSanSnapshot = await db.collection('DatSan')
        .where('MaSan', isEqualTo: maSan)
        .where('NgayDenSan', isEqualTo: ngayDat)
        .where('GioBatDau', isEqualTo: gioDat)
        .get();

    var san = San.fromJson(sanSnapshot.docs.first.data()!);
    if (datSanSnapshot.docs.isNotEmpty) {
      for (var datSanDoc in datSanSnapshot.docs) {
        var datSan = DatSan.fromJson(datSanDoc.data()!);

        for (var sancon in san.SanCons!) {
          if (sancon == datSan.ViTriSan) {
            var data = {
              'TenSan': san.TenSan,
              'TenSanCon': sancon,
              'TinhTrang': 'Đang được đặt',
            };
            results.add(data);
          } else {
            var data = {
              'TenSan': san.TenSan,
              'TenSanCon': sancon,
              'TinhTrang': 'Còn Trống',
            };
            results.add(data);
          }
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
    print(results);
    yield results;
  }

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
            print(joinedRow);
            joinedData.add(joinedRow);
          }
        }
      }

      streamController.add(joinedData);
    });

    return streamController.stream;
  }
}
