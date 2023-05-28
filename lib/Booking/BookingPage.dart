import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:quanlysanbong/Booking/CostTablePage.dart';
import 'package:quanlysanbong/Booking/DetailsBookingPage.dart';
import 'package:quanlysanbong/Firebase/Connect_Firebase.dart';
import 'package:quanlysanbong/Firebase/JoinTable.dart';
import 'package:quanlysanbong/Firebase/San_Data.dart';
import 'package:quanlysanbong/Helpers/WidgetHelper.dart';

class FireBaseBooking extends StatelessWidget {
  String? maTK;
  String? maSan;
  FireBaseBooking({Key? key, required this.maTK, required this.maSan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(
        builder: (context) => PageBooking(maTK: maTK, maSan: maSan,),
        errorMessage: "Lỗi kết nối với firebase!",
        connectingMessage: "Vui lòng đợi kết nối!"
    );
  }
}



class PageBooking extends StatefulWidget {
  String? maTK;
  String? maSan;
  PageBooking({Key? key, required this.maTK, required this.maSan}) : super(key: key);

  @override
  State<PageBooking> createState() => _PageBookingState();
}

class _PageBookingState extends State<PageBooking> {
  String? maTK;
  String? maSan;
  TextEditingController txtDateInput = TextEditingController();
  TextEditingController txtGioDatInput = TextEditingController();

  @override
  void initState() {
    maTK = widget.maTK;
    maSan = widget.maSan;
    txtDateInput.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    txtGioDatInput.text = "${DateTime.now().hour + 1}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: 90,),
            Text("Đặt sân",
            style: TextStyle(
              fontSize: 25,
            ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Container(
              child: Container(
                height: 150,
                padding: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.green, width: 2
                  ),
                  borderRadius: const BorderRadius.all(Radius.elliptical(20, 20)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 200,
                      child: TextField(
                        controller: txtDateInput,
                        decoration: const InputDecoration(
                            icon: Icon(Icons.calendar_today),
                            labelText: "Ngày đặt"
                        ),
                        readOnly: true,  //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context, initialDate: DateTime.now(),
                              firstDate: DateTime(2023),
                              lastDate: DateTime(2101)
                          );

                          if(pickedDate != null ){
                            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                            setState(() {
                              txtDateInput.text = formattedDate;
                            });
                          } else {
                            print("Date is not selected");
                          }
                        },
                        style: const TextStyle(fontSize: 25),
                      ),
                    ),
                    Container(
                      width: 130,
                      child: TextField(
                        controller: txtGioDatInput,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          NumericalRangeFormatter(min: 1, max: 21)
                        ],
                        decoration: const InputDecoration(
                            icon: Icon(Icons.timer_outlined),
                            labelText: "Giờ đặt"
                        ),
                        style: const TextStyle(fontSize: 25),
                        onSubmitted: (value) {
                          setState(() {
                            txtGioDatInput.text = value;
                          });
                        },
                      ),
                    )
                  ]
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 10,),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => FireBaseCostTable(maSan: maSan),));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[300],
                        padding: const EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
                        shape: const RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.black
                            )
                        )
                    ),
                    child: const Text("Xem bảng giá", style: TextStyle(
                        color: Colors.black,
                        fontSize: 15
                    ))
                ),
              ],
            ),
            const SizedBox(height: 10),
            StreamBuilder<List<dynamic>>(
              stream: JoinTable.getTinhTrangSanCon(maSan!, txtDateInput.text, int.parse(txtGioDatInput.text)),
              builder: (context, snapshot) {
                if(snapshot.hasError) {
                  print("Lỗi nè");
                  print(snapshot.error);
                  return const Center(
                    child: Text("Lỗi dữ liệu Firebase",
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                } else if(!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  var list = snapshot.data!;
                  return Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FireBaseDetailsBooking(
                                maTK: maTK,
                                maSan: maSan,
                                ngayDat: txtDateInput.text,
                                gioDat: txtGioDatInput.text,
                                tenSan: list[index]['TenSan'],
                                viTriSan: list[index]['TenSanCon'],
                              )
                            )
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.elliptical(20, 20)),
                            border: Border.all(width: 2),
                            color: list[index]['TinhTrang'] == "Còn Trống" ? Colors.green : Colors.red
                          ),
                          child: Container(
                            height: 120,
                            child: Column(
                              children: [
                                Text("${list[index]['TenSan']}", style:
                                   TextStyle(
                                      color: list[index]['TinhTrang'] == "Còn Trống" ? Colors.black : Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold
                                  )
                                ),
                                const SizedBox(height: 15),
                                Text("${list[index]['TenSanCon']}", style: TextStyle(
                                  fontSize: 25,
                                  color: list[index]['TinhTrang'] == "Còn Trống" ? Colors.black : Colors.white,
                                )),
                                const SizedBox(height: 15),
                                Text("${list[index]['TinhTrang']}", style: TextStyle(
                                  fontSize: 20,
                                  color: list[index]['TinhTrang'] == "Còn Trống" ? Colors.black : Colors.white,
                                ))
                              ],
                            ),
                          )
                        ),
                      ),
                      separatorBuilder: (context, index) => const SizedBox(height: 30),
                      itemCount: list!.length
                  ));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
