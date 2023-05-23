import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:quanlysanbong/Firebase/DatSan_Data.dart';

class DatSanController extends GetxController {
  final _listDatSanSN = <DatSanSnapShot>[].obs;
  List<DatSanSnapShot> get listDatSanSN => _listDatSanSN.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
  }

  void getData(){
    DatSanSnapShot.dsDatSanTuFirebaseOneTime()
        .then((value) {
      _listDatSanSN.value = value;
      _listDatSanSN.refresh();
    })
        .catchError((error){
      print(error);
      _listDatSanSN.value = [];
      _listDatSanSN.refresh();
    });
  }

}