import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:quanlysanbong/Firebase/Connect_Firebase.dart';
import 'package:quanlysanbong/Firebase/JoinTable.dart';
import 'package:quanlysanbong/Firebase/San_Data.dart';
import 'package:quanlysanbong/Helpers/WidgetHelper.dart';
import 'package:quanlysanbong/Utils/Utils.dart';

class FirePaseSeeDetailsBooking extends StatelessWidget {
  String? ngayDat;
  String? gioBatDau;
  String? gioKetThuc;
  String? maTK;
  String? maSan;
  String? tenSan;
  String? viTriSan;
  String? thanhTien;
  String? diaChi;

  FirePaseSeeDetailsBooking(
      {Key? key,
        required this.maTK,
        required this.maSan,
        required this.ngayDat,
        required this.gioBatDau,
        required this.gioKetThuc,
        required this.tenSan,
        required this.viTriSan,
        required this.thanhTien,
        required this.diaChi,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(
        builder: (context) => PaseSeeDetailsBooking(
          maTK: maTK,
          maSan: maSan,
          gioBatDau: gioBatDau,
          gioKetThuc: gioKetThuc,
          ngayDat: ngayDat,
          tenSan: tenSan,
          viTriSan: viTriSan,
          thanhTien: thanhTien,
          diaChi: diaChi,
        ),
        errorMessage: "Lỗi kết nối với firebase!",
        connectingMessage: "Vui lòng đợi kết nối!"
    );
  }
}



class PaseSeeDetailsBooking extends StatefulWidget {
  String? ngayDat;
  String? gioBatDau;
  String? gioKetThuc;
  String? maTK;
  String? maSan;
  String? tenSan;
  String? viTriSan;
  String? thanhTien;
  String? diaChi;


  PaseSeeDetailsBooking(
      {Key? key,
        required this.maTK,
        required this.maSan,
        required this.ngayDat,
        required this.gioBatDau,
        required this.gioKetThuc,
        required this.tenSan,
        required this.viTriSan,
        required this.thanhTien,
        required this.diaChi
      }) : super(key: key);

  @override
  State<PaseSeeDetailsBooking> createState() => _PaseSeeDetailsBookingState();
}

class _PaseSeeDetailsBookingState extends State<PaseSeeDetailsBooking> {
  String? ngayDat;
  String? gioBatDau;
  String? gioKetThuc;
  String? maTK;
  String? maSan;
  String? tenSan;
  String? viTriSan;
  String? thanhTien;
  String? diaChi;

  @override
  void initState() {
    maTK = widget.maTK;
    maSan = widget.maSan;
    ngayDat = widget.ngayDat;
    gioBatDau = widget.gioBatDau;
    tenSan = widget.tenSan;
    viTriSan = widget.viTriSan;
    thanhTien = widget.thanhTien;
    diaChi = widget.diaChi;
    gioKetThuc = widget.gioKetThuc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Row(
          children: const [
            SizedBox(width: 60,),
            Text("Phiếu đặt sân",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.green,
                width: 3,
                style: BorderStyle.solid
            ),
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 20,
              right: 20,
              bottom: 10,
            ),
            child: Column(
              children: [
                const SizedBox(height: 30,),
                Row(
                  children: [
                    const SizedBox(width: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 150,
                          height: 55,
                          child: const Text("Ngày đặt",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40,),
                        Container(
                          width: 150,
                          height: 55,
                          child: const Text("Giờ bắt đầu",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40,),
                        Container(
                          width: 150,
                          height: 55,
                          child: const Text("Giờ kết thúc",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40,),
                        Container(
                          width: 150,
                          height: 55,
                          child: const Text("Tên sân",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40,),
                        Container(
                          width: 150,
                          height: 55,
                          child: const Text("Địa chỉ",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40,),
                        Container(
                          width: 150,
                          height: 55,
                          child: const Text("Vị trí sân",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40,),
                        Container(
                          width: 150,
                          height: 55,
                          child: const Text("Thành tiền",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 15,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 150,
                          height: 55,
                          child: Text("${ngayDat}",
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40,),
                        Container(
                          width: 150,
                          height: 55,
                          child: Text("${gioBatDau} giờ",
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 50,),
                        Container(
                          width: 150,
                          height: 55,
                          child: Text("${gioKetThuc} giờ",
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40,),
                        Container(
                          width: 150,
                          height: 55,
                          child: Text("${tenSan}",
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40,),
                        Container(
                          width: 150,
                          height: 55,
                          child: Text("${diaChi}",
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40,),
                        Container(
                          width: 150,
                          height: 55,
                          child: Text("${viTriSan}",
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40,),
                        Container(
                          width: 150,
                          height: 55,
                          child: Text("$thanhTien vnđ",
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
