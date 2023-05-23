import 'package:cloud_firestore/cloud_firestore.dart';

class DatSan {
  String? MaCTS, MaDS, MaTK, NgayDenSan;
  int GioBatDau, GioKetThuc;

  DatSan({
    this.MaCTS,
    this.MaDS,
    this.MaTK,
    this.NgayDenSan,
    required this.GioBatDau,
    required this.GioKetThuc,
  });

  Map<String, dynamic> toJson() {
    return {
      'MaCTS': this.MaCTS,
      'MaDS': this.MaDS,
      'MaTK': this.MaTK,
      'NgayDenSan': this.NgayDenSan,
      'GioBatDau': this.GioBatDau,
      'GioKetThuc': this.GioKetThuc,
    };
  }

  factory DatSan.parseToObject(Map<String, dynamic> map) {
    return DatSan(
      MaCTS: map['MaCTS'] as String,
      MaDS: map['MaDS'] as String,
      MaTK: map['MaTK'] as String,
      NgayDenSan: map['NgayDenSan'] as String,
      GioBatDau: map['GioBatDau'] as int,
      GioKetThuc: map['GioKetThuc'] as int,
    );
  }
}

class DatSanSnapShot {
  DatSan? datSan;
  DocumentReference? documentReference;

  DatSanSnapShot({
    this.datSan,
    this.documentReference,
  });

  factory DatSanSnapShot.fromSnapShot(DocumentSnapshot docSnapDatSan) {
    return DatSanSnapShot(
        datSan:  DatSan.parseToObject(docSnapDatSan.data() as Map<String, dynamic>),
        documentReference: docSnapDatSan.reference
    );
  }

  Future<void> capNhat(DatSan datSan) {
    return documentReference!.update(datSan.toJson());
  }

  Future<void> xoa() async{
    return documentReference!.delete();
  }

  static Future<DocumentReference> themMoi(DatSan datSan) async{
    return FirebaseFirestore.instance.collection("DatSan").add(datSan.toJson());
  }

  static Stream<List<DatSanSnapShot>> getAll(){
    Stream<QuerySnapshot> streamQS = FirebaseFirestore.instance.collection("DatSan").snapshots();
    return streamQS.map((qs) => qs.docs).map((listDocSnap) =>
        listDocSnap.map((docSnap) => DatSanSnapShot.fromSnapShot(docSnap)).toList());
  }

  static Future<List<DatSanSnapShot>> dsDatSanTuFirebaseOneTime() async{
    QuerySnapshot qs = await FirebaseFirestore.instance.collection("DatSan").get();
    return qs.docs.map((doc) => DatSanSnapShot.fromSnapShot(doc)).toList();
  }
}