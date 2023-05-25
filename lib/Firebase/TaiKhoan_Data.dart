import 'package:cloud_firestore/cloud_firestore.dart';

class TaiKhoan{
  String? MaTK, HoTen, TenTK, MatKhau, SDT, Email, DiaChi;
  int? DiemTich;
  bool? Quyen,Vip;

  TaiKhoan({
    required this.MaTK,
    required this.HoTen,
    required this.TenTK,
    required this.MatKhau,
    required this.SDT,
    required this.Email,
    required this.DiaChi,
    required this.DiemTich,
    required this.Quyen,
    required this.Vip
  });

  Map<String, dynamic> toJson(){
    return {
      'MaTK': this.MaTK,
      'HoTen': this.HoTen,
      'TenTK': this.TenTK,
      'MatKhau': this.MatKhau,
      'SDT': this.SDT,
      'Email': this.Email,
      'DiaChi': this.DiaChi,
      'DiemTich': this.DiemTich,
      'Quyen': this.Quyen,
      'Vip': this.Vip,
    };
  }
  factory TaiKhoan.fromJson(Map<String, dynamic> map) {
    return TaiKhoan(
      MaTK: map['MaTK'] as String,
      HoTen: map['HoTen'] as String,
      TenTK: map['TenTK'] as String,
      MatKhau: map['MatKhau'] as String,
      SDT: map['SDT'] as String,
      Email: map['Email'] as String,
      DiaChi: map['DiaChi'] as String,
      DiemTich: map['DiemTich'] as int,
      Quyen: map['Quyen'] as bool,
      Vip: map['Vip'] as bool,
    );
  }
}
class TaiKhoanSnapShot{
  TaiKhoan? taiKhoan;
  DocumentReference? documentReference;

  TaiKhoanSnapShot({
    required this.taiKhoan,
    required this.documentReference
  });

  factory TaiKhoanSnapShot.fromSnapShot(DocumentSnapshot docSnapTaiKhoan) {
    return TaiKhoanSnapShot(
        taiKhoan:  TaiKhoan.fromJson(docSnapTaiKhoan.data() as Map<String, dynamic>),
        documentReference: docSnapTaiKhoan.reference
    );
  }
  Future<void>  capNhat(TaiKhoan taiKhoan) async{
    return documentReference!.update(taiKhoan.toJson());
  }
  Future<void> xoa() async{
    return documentReference!.delete();
  }
  static Future<DocumentReference> themMoi(TaiKhoan taiKhoan) async{
    return FirebaseFirestore.instance.collection("TaiKhoan").add(taiKhoan.toJson());
  }
  static Stream<List<TaiKhoanSnapShot>> getAll(){
    Stream<QuerySnapshot> streamQS = FirebaseFirestore.instance.collection("TaiKhoan").snapshots();
    return streamQS.map((qs) => qs.docs).map((listDocSnap) =>
        listDocSnap.map((docSnap) => TaiKhoanSnapShot.fromSnapShot(docSnap)).toList());
  }
  static Future<List<TaiKhoanSnapShot>> dsTaiKhoanTuFirebaseOneTime() async{
    QuerySnapshot qs = await FirebaseFirestore.instance.collection("TaiKhoan").get();
    return qs.docs.map((doc) => TaiKhoanSnapShot.fromSnapShot(doc)).toList();
  }
}