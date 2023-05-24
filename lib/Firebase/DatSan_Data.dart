import 'package:cloud_firestore/cloud_firestore.dart';

class DatSan {
  String?  MaSan,MaTK, NgayDenSan,ViTriSan;
  int? GioBatDau, GioKetThuc, TongTien;

  DatSan({
    this.MaSan,
    this.MaTK,
    this.NgayDenSan,
    this.ViTriSan,
    this.GioBatDau,
    this.GioKetThuc,
    this.TongTien,
  });

  Map<String, dynamic> toJson() {
    return {
      'MaSan': this.MaSan,
      'MaTK': this.MaTK,
      'NgayDenSan': this.NgayDenSan,
      'ViTriSan': this.ViTriSan,
      'GioBatDau': this.GioBatDau,
      'GioKetThuc': this.GioKetThuc,
      'TongTien': this.TongTien,
    };
  }

  factory DatSan.fromJson(Map<String, dynamic> map) {
    return DatSan(
      MaSan: map['MaSan'] as String,
      MaTK: map['MaTK'] as String,
      NgayDenSan: map['NgayDenSan'] as String,
      ViTriSan: map['ViTriSan'] as String,
      GioBatDau: map['GioBatDau'] as int,
      GioKetThuc: map['GioKetThuc'] as int,
      TongTien: map['TongTien'] as int,
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
        datSan:  DatSan.fromJson(docSnapDatSan.data() as Map<String, dynamic>),
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