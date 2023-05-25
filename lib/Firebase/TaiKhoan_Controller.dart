import 'package:get/get.dart';
import 'package:quanlysanbong/Firebase/TaiKhoan_Data.dart';

class TaiKhoanController extends GetxController {
  final _listTaiKhoanSN = <TaiKhoanSnapShot>[].obs;
  List<TaiKhoanSnapShot> get listTaiKhoanSN => _listTaiKhoanSN.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
  }

  void getData(){
    TaiKhoanSnapShot.dsTaiKhoanTuFirebaseOneTime()
        .then((value) {
      _listTaiKhoanSN.value = value;
      _listTaiKhoanSN.refresh();
    })
        .catchError((error){
      print(error);
      _listTaiKhoanSN.value = [];
      _listTaiKhoanSN.refresh();
    });
  }

}