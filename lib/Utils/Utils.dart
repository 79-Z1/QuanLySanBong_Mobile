import 'package:quanlysanbong/Firebase/JoinTable.dart';

extension DateOnlyCompare on DateTime {
  bool compareDate(DateTime other) {
    if(year >= other.year && month > other.month) {
      return true;
    } else if(month == other.month) {
      if(day >= other.day) return true;
      else return false;
    } else return false;
  }
}

String _layTenNguoiDungTuMaTK(String maTK){
  Stream<List<Map<dynamic, dynamic>>>? taiKhoan = JoinTable.TaiKhoanFromMaTK(maTK);

  return "â";
}







