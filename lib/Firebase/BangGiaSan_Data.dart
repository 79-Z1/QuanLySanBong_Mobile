import 'package:cloud_firestore/cloud_firestore.dart';

class BangGiaSan{
  String? MaSan, GiaTheoGio;
  int? Gio;

  BangGiaSan({
    this.MaSan,
    this.Gio,
    this.GiaTheoGio,
  });

  Map<String, dynamic> toJson() {
    return {
      'MaSan': this.MaSan,
      'GiaTheoGio': this.GiaTheoGio,
      'Gio': this.Gio,
    };
  }

  factory BangGiaSan.fromJson(Map<String, dynamic> map) {
    return BangGiaSan(
      MaSan: map['MaSan'] as String,
      GiaTheoGio: map['GiaTheoGio'] as String,
      Gio: map['Gio'] as int,
    );
  }
}
class BangGiaSanSnapShot{
  BangGiaSan? bangGiaSan;
  DocumentReference? documentReference;
  BangGiaSanSnapShot({
    required this.bangGiaSan,
    required this.documentReference,
  });
  factory BangGiaSanSnapShot.fromSnapShot(DocumentSnapshot docSnapBangGiaSan) {
    return BangGiaSanSnapShot(
        bangGiaSan:  BangGiaSan.fromJson(docSnapBangGiaSan.data() as Map<String, dynamic>),
        documentReference: docSnapBangGiaSan.reference
    );
  }
  Future<void>  capNhat(BangGiaSan bangGiaSan) async{
    return documentReference!.update(bangGiaSan.toJson());
  }
  Future<void> xoa() async{
    return documentReference!.delete();
  }
  static Future<DocumentReference> themMoi(BangGiaSan bangGiaSan) async{
    return FirebaseFirestore.instance.collection("BangGiaSan").add(bangGiaSan.toJson());
  }
  static Stream<List<BangGiaSanSnapShot>> getAll(){
    Stream<QuerySnapshot> streamQS = FirebaseFirestore.instance.collection("BangGiaSan").snapshots();
    return streamQS.map((qs) => qs.docs).map((listDocSnap) =>
        listDocSnap.map((docSnap) => BangGiaSanSnapShot.fromSnapShot(docSnap)).toList());
  }

  static Future<List<BangGiaSanSnapShot>> dsSanTuFirebaseOneTime() async{
    QuerySnapshot qs = await FirebaseFirestore.instance.collection("BangGiaSan").get();
    return qs.docs.map((doc) => BangGiaSanSnapShot.fromSnapShot(doc)).toList();
  }
}