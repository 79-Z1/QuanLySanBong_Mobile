import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quanlysanbong/Firebase/ChiTietSan.dart';
import 'package:quanlysanbong/Firebase/DatSan_Data.dart';


class San_DatSan {

  static Stream<List<dynamic>> joinChiTietSanAndDatSan() async* {
    var chiTietSanCollection = FirebaseFirestore.instance.collection('ChiTietSan');
    var datSanCollection = FirebaseFirestore.instance.collection('DatSan');

    var snapshots = await FirebaseFirestore.instance.collectionGroup('ChiTietSan').get();
    var chiTietSanList = snapshots.docs.map((doc) => ChiTietSan.fromJson(doc.data())).toList();

    snapshots = await FirebaseFirestore.instance.collectionGroup('DatSan').get();
    var datSanList = snapshots.docs.map((doc) => DatSan.parseToObject(doc.data())).toList();

    var joinList = <Map<String, dynamic>>[];

    for (var chiTietSan in chiTietSanList) {
      var datSanDocs = await datSanCollection.where('MaCTS', isEqualTo: chiTietSan.MaCTS).get();
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

      var querySnapshot = await db
          .collectionGroup('DatSan')
          .where('MaCTS', isEqualTo: chiTietSan.MaCTS)
          .get();

      for (var queryDoc in querySnapshot.docs) {
        var datSan = DatSan.parseToObject(queryDoc.data()!);

        var data = {
          ...chiTietSan.toJson(),
          ...datSan.toJson(),
        };

        results.add(data);
      }
    }

    yield results;
  }


  // static Stream<List<dynamic>> joinCollectionsAsStream() {
  //   final sanCollection = FirebaseFirestore.instance.collection('San');
  //   final bangGiaSanCollection = FirebaseFirestore.instance.collection('BangGiaSan');
  //
  //   return Rx.combineLatest2(sanCollection.snapshots(), bangGiaSanCollection.snapshots(),
  //           (QuerySnapshot sanSnapShot, QuerySnapshot bangGiaSanSnapShot) {
  //         final bangGiaSanDatas = bangGiaSanSnapShot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  //         final sanDatas = sanSnapShot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  //
  //         return sanDatas.map((san) {
  //           final bangGiaData = bangGiaSanDatas.firstWhere((bangGia) => san['MaSan'] == bangGia['MaSan']);
  //
  //           return {...san, 'BangGia': bangGiaData};
  //         }).toList();
  //       });
  // }
}