import 'package:cloud_firestore/cloud_firestore.dart';

class San{
  String? Anh, DiaChi, MaSan, TenSan;
  List<dynamic>? SanCons;

  San({
    this.Anh,
    this.DiaChi,
    this.MaSan,
    this.TenSan,
    this.SanCons,
  });

  Map<String, dynamic> toJson() {
    return {
      'Anh': this.Anh,
      'DiaChi': this.DiaChi,
      'MaSan': this.MaSan,
      'TenSan': this.TenSan,
      'SanCons': this.SanCons,
    };
  }

  factory San.fromJson(Map<String, dynamic> map) {
    return San(
      Anh: map['Anh'] as String,
      DiaChi: map['DiaChi'] as String,
      MaSan: map['MaSan'] as String,
      TenSan: map['TenSan'] as String,
      SanCons: map['SanCons'] as List<dynamic>,
    );
  }
}
class SanSnapShot{
  San? san;
  DocumentReference? documentReference;
  SanSnapShot({
    required this.san,
    required this.documentReference,
  });
  factory SanSnapShot.fromSnapShot(DocumentSnapshot docSnapSan) {
    return SanSnapShot(
        san:  San.fromJson(docSnapSan.data() as Map<String, dynamic>),
        documentReference: docSnapSan.reference
    );
  }
  Future<void>  capNhat(San san) async{
    return documentReference!.update(san.toJson());
  }
  Future<void> xoa() async{
    return documentReference!.delete();
  }
  static Future<DocumentReference> themMoi(San san) async{
    return FirebaseFirestore.instance.collection("San").add(san.toJson());
  }
  static Stream<List<SanSnapShot>> getAll(){
    Stream<QuerySnapshot> streamQS = FirebaseFirestore.instance.collection("San").snapshots();
    return streamQS.map((qs) => qs.docs).map((listDocSnap) =>
        listDocSnap.map((docSnap) => SanSnapShot.fromSnapShot(docSnap)).toList());
  }
  static Future<List<SanSnapShot>> dsSanTuFirebaseOneTime() async{
    QuerySnapshot qs = await FirebaseFirestore.instance.collection("San").get();
    return qs.docs.map((doc) => SanSnapShot.fromSnapShot(doc)).toList();
  }
}