import 'package:cloud_firestore/cloud_firestore.dart';

class ChiTietSan{
  String? MaCTS, MaSan, SoSan;
  ChiTietSan({
    required this.MaCTS,
    required this.MaSan,
    required this.SoSan,
  });
  Map<String, dynamic> toJson(){
    return {
      'MaCTS': this.MaCTS,
      'MaSan': this.MaSan,
      'SoSan': this.SoSan,
    };
  }
  factory ChiTietSan.fromJson(Map<String, dynamic> map) {
    return ChiTietSan(
      MaCTS: map['MaCTS'] as String,
      MaSan: map['MaSan'] as String,
      SoSan: map['SoSan'] as String,
    );
  }
}
class ChiTietSanSnapShot{
  ChiTietSan? chiTietSan;
  DocumentReference? documentReference;
  ChiTietSanSnapShot({
    required this.chiTietSan,
    required this.documentReference,
  });
  factory ChiTietSanSnapShot.fromSnapShot(DocumentSnapshot docSnapChiTietSan) {
    return ChiTietSanSnapShot(
        chiTietSan:  ChiTietSan.fromJson(docSnapChiTietSan.data() as Map<String, dynamic>),
        documentReference: docSnapChiTietSan.reference
    );
  }
  Future<void>  capNhat(ChiTietSan chiTietSan) async{
    return documentReference!.update(chiTietSan.toJson());
  }
  Future<void> xoa() async{
    return documentReference!.delete();
  }
  static Future<DocumentReference> themMoi(ChiTietSan chiTietSan) async{
    return FirebaseFirestore.instance.collection("ChiTietSan").add(chiTietSan.toJson());
  }
  static Stream<List<ChiTietSanSnapShot>> getAll(){
    Stream<QuerySnapshot> streamQS = FirebaseFirestore.instance.collection("ChiTietSan").snapshots();
    return streamQS.map((qs) => qs.docs).map((listDocSnap) =>
        listDocSnap.map((docSnap) => ChiTietSanSnapShot.fromSnapShot(docSnap)).toList());
  }
  static Future<List<ChiTietSanSnapShot>> dsSanTuFirebaseOneTime() async{
    QuerySnapshot qs = await FirebaseFirestore.instance.collection("ChiTietSan").get();
    return qs.docs.map((doc) => ChiTietSanSnapShot.fromSnapShot(doc)).toList();
  }
}