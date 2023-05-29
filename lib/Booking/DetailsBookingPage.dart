import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:quanlysanbong/Firebase/Connect_Firebase.dart';
import 'package:quanlysanbong/Firebase/DatSan_Data.dart';
import 'package:quanlysanbong/Firebase/JoinTable.dart';
import 'package:quanlysanbong/Firebase/San_Data.dart';
import 'package:quanlysanbong/Firebase/TaiKhoan_Data.dart';
import 'package:quanlysanbong/Helpers/WidgetHelper.dart';
import 'package:quanlysanbong/History/HistoryPage.dart';
import 'package:quanlysanbong/Home/HomePage.dart';
import 'package:quanlysanbong/Utils/Utils.dart';

class FireBaseDetailsBooking extends StatelessWidget {
  String? ngayDat;
  String? gioDat;
  String? maTK;
  String? maSan;
  String? tenSan;
  String? viTriSan;
  FireBaseDetailsBooking(
      {Key? key,
        required this.maTK,
        required this.maSan,
        required this.ngayDat,
        required this.gioDat,
        required this.tenSan,
        required this.viTriSan,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(
        builder: (context) => PageDetailsBooking(
            maTK: maTK,
            maSan: maSan,
            gioDat: gioDat,
            ngayDat: ngayDat,
            tenSan: tenSan,
            viTriSan: viTriSan,
        ),
        errorMessage: "Lỗi kết nối với firebase!",
        connectingMessage: "Vui lòng đợi kết nối!"
    );
  }
}

class PageDetailsBooking extends StatefulWidget {
  String? ngayDat;
  String? gioDat;
  String? maTK;
  String? maSan;
  String? tenSan;
  String? viTriSan;
  PageDetailsBooking(
      {Key? key,
        required this.maTK,
        required this.maSan,
        required this.ngayDat,
        required this.gioDat,
        required this.tenSan,
        required this.viTriSan,
      }) : super(key: key);

  @override
  State<PageDetailsBooking> createState() => _PageDetailsBookingState();
}

class _PageDetailsBookingState extends State<PageDetailsBooking> {
  String? ngayDat;
  String? gioDat;
  String? maTK;
  String? maSan;
  String? tenSan;
  String? viTriSan;
  TextEditingController txtSoGioInput = TextEditingController();

  int? gioKetThuc;
  double? tongTien;
  final NumberFormat usCurrency = NumberFormat('#,##0', 'en_US');

  @override
  void initState() {
    maTK = widget.maTK;
    maSan = widget.maSan;
    ngayDat = widget.ngayDat;
    gioDat = widget.gioDat;
    tenSan = widget.tenSan;
    viTriSan = widget.viTriSan;
    txtSoGioInput.text = "1";
    gioKetThuc = int.parse(gioDat.toString())  + int.parse(txtSoGioInput.text);
    tongTien = 0;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: 60,),
            Text("Phiếu đặt sân",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.green,
              width: 3,
              style: BorderStyle.solid
            ),
            borderRadius: BorderRadius.all(Radius.circular(30)),
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
                SizedBox(height: 30,),
                Row(
                  children: [
                    SizedBox(width: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 150,
                          height: 55,
                          child: Text("Ngày đặt",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        Container(
                          width: 150,
                          height: 55,
                          child: Text("Giờ bắt đầu",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        Container(
                          width: 150,
                          height: 55,
                          child: Text("Số giờ đặt",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        Container(
                          width: 150,
                          height: 55,
                          child: Text("Giờ kết thúc",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        Container(
                          width: 150,
                          height: 55,
                          child: Text("Tên sân",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        Container(
                          width: 150,
                          height: 55,
                          child: Text("Vị trí sân",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        Container(
                          width: 150,
                          height: 55,
                          child: Text("Giảm giá",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        Container(
                          width: 150,
                          height: 55,
                          child: Text("Thành tiền",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 15,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 150,
                          height: 55,
                          child: Text("${ngayDat}",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        Container(
                          width: 150,
                          height: 55,
                          child: Text("${gioDat}",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          width: 30,
                          height: 55,
                          child: TextField(
                            controller: txtSoGioInput,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              NumericalRangeFormatter(min: 1, max: 5,)
                            ],

                            style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                            onSubmitted: (value) {
                              setState(() {
                                txtSoGioInput.text = value;
                                gioKetThuc = int.parse(gioDat.toString()) + int.parse(txtSoGioInput.text);
                                setState(() {

                                });
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 40,),
                        Container(
                          width: 150,
                          height: 55,
                          child: Text("${gioKetThuc}",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        Container(
                          width: 150,
                          height: 55,
                          child: Text("${tenSan}",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        Container(
                          width: 150,
                          height: 55,
                          child: Text("${viTriSan}",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        StreamBuilder(
                            stream: JoinTable.tinhTienSan(
                                maTK!, maSan!, int.parse(gioDat.toString()), gioKetThuc!),
                            builder: (context, snapshot) {
                              if(snapshot.hasError) {
                                print("Lỗi nè");
                                print(snapshot.error);
                                 return
                                Column(
                                  children: [
                                    Container(
                                      width: 150,
                                      height: 55,
                                      child: Text("0 vnđ",
                                        style: TextStyle(
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 30,),
                                    Container(
                                      width: 150,
                                      height: 55,
                                      child: Text("Chúng tôi không mở sân trong khoảng 10h-14h hoặc 22h-4h",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else if(!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }else {
                                var list = snapshot.data!;
                                tongTien = list[0]['TongTien'];
                                return Column(
                                  children: [
                                    Container(
                                          width: 150,
                                          height: 55,
                                          child: Text("${usCurrency.format(list[0]['SoTienGiam'])} vnđ",
                                            style: TextStyle(
                                              fontSize: 23,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                    SizedBox(height: 30,),
                                    Container(
                                      width: 150,
                                      height: 55,
                                      child: Text("${usCurrency.format(list[0]['TongTien'])} vnđ",
                                        style: TextStyle(
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            },
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 50,),
                ElevatedButton(
                    onPressed: () {
                        FirebaseFirestore.instance
                            .collection('TaiKhoan')
                            .where('MaTK', isEqualTo: maTK) // MaTK là giá trị cụ thể của MaTK mà bạn muốn cập nhật
                            .get()
                            .then((querySnapshot) {
                          querySnapshot.docs.forEach((documentSnapshot) {
                            var taiKhoan = TaiKhoan.fromJson(documentSnapshot.data()!);
                            int diem = taiKhoan.DiemTich! + (gioKetThuc! - int.parse(gioDat.toString()))*10;
                            documentSnapshot.reference.update({
                              'DiemTich':  diem,
                            });
                          });
                        });
                        for(int i = int.parse(gioDat.toString()); i < gioKetThuc!; i++){
                          DatSan datSan = new DatSan(
                            MaSan: maSan,
                            MaTK: "HideBooking",
                            ViTriSan: viTriSan,
                            NgayDenSan: ngayDat,
                            GioBatDau: i,
                            GioKetThuc: i+1,
                            TongTien: tongTien!.toInt(),
                          );
                          DatSanSnapShot.themMoi(datSan);
                        }
                        DatSan datSan = new DatSan(
                          MaSan: maSan,
                          MaTK: maTK,
                          ViTriSan: viTriSan,
                          NgayDenSan: ngayDat,
                          GioBatDau: int.parse(gioDat.toString()),
                          GioKetThuc: gioKetThuc,
                          TongTien: tongTien!.toInt(),
                        );
                        DatSanSnapShot.themMoi(datSan).whenComplete(()
                        {
                          showSnackbar(context, "Đã đặt sân thành công, bạn có thể kiểm tra trong lịch sử");
                          Navigator.pop(context);
                        }
                        );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
                        shape: const RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.black
                            )
                        )
                    ),
                    child: const Text("Đặt sân", style: TextStyle(
                        color: Colors.black,
                        fontSize: 25
                    ))
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }
}
void showSnackbar(BuildContext context,  String message){
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      )
  );
}

