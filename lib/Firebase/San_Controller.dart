import 'package:get/get.dart';
import 'package:quanlysanbong/Firebase/San_Data.dart';

class SanController extends GetxController{
  final _listSanSN = <SanSnapShot>[].obs;
  List<SanSnapShot> get listSanSN => _listSanSN.value;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
  }

  void getData(){
    SanSnapShot.dsSanTuFirebaseOneTime()
        .then((value) {
      _listSanSN.value = value;
      _listSanSN.refresh();
    })
        .catchError((error){
      print(error);
      _listSanSN.value = [];
      _listSanSN.refresh();
    });
  }
}