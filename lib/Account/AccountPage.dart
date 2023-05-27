import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quanlysanbong/Authen/LoginPage.dart';
import 'package:quanlysanbong/Firebase/Connect_Firebase.dart';
import 'package:quanlysanbong/Firebase/DatSan_Data.dart';
import 'package:quanlysanbong/Firebase/JoinTable.dart';
import 'package:quanlysanbong/History/HistoryPage.dart';
import 'package:quanlysanbong/Home/HomePage.dart';
import 'package:quanlysanbong/Rss/Page/PageRss.dart';
import 'package:quanlysanbong/Utils/Utils.dart';

class FireBaseAccount extends StatelessWidget {
  String? maTK;
  FireBaseAccount({Key? key, required this.maTK}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(
        builder: (context) => PageAccount(maTK: this.maTK),
        errorMessage: "Lỗi kết nối với firebase!",
        connectingMessage: "Vui lòng đợi kết nối!"
    );
  }
}

class PageAccount extends StatefulWidget {
  String? maTK;
  PageAccount({Key? key , required this.maTK}) : super(key: key);

  @override
  State<PageAccount> createState() => _PageAccountState();
}

class _PageAccountState extends State<PageAccount> {
  String? maTK;
  int indexBar = 1;
  @override
  Widget build(BuildContext context) {
    int indexBar = 0;
    // var screenHeight = MediaQuery.of(context).size.height;
    // var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 30),
            color: Colors.green,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 20, height: 20),
                InkWell(
                  child: const Icon(
                    CupertinoIcons.arrow_left_circle_fill,
                    color: Colors.white,
                    size: 40,
                  ),
                  onTap: () {
                    Get.to( FirebaseHome(maTK: maTK!));
                  },
                ),
                const SizedBox(width: 30,),
                const Text("Thông tin tài khoản", style: TextStyle(fontSize: 30, color: Colors.white))
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 80),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                )
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Icon(Icons.account_circle,size: 100,color: Colors.green,),
                const SizedBox(height: 10),
                const Divider(
                  color: Colors.black, thickness: 2,
                ),
                StreamBuilder<List<dynamic>>(
                  stream: JoinTable.TaiKhoanFromMaTK(maTK!),
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
                      return Column(
                        children: [
                          SizedBox(height: 40,),
                          Row(
                            children: [
                              SizedBox(width: 20,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text("Số điện thoại",
                                      style: TextStyle(
                                      fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                    ),
                                    ),
                                  SizedBox(height: 50,),
                                    Text("Họ tên",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  SizedBox(height: 50,),
                                    Text("Email",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  SizedBox(height: 50,),
                                    Text("Địa chỉ",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  SizedBox(height: 50,),
                                    Text("Thành viên",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  SizedBox(height: 50,),
                                    Text("Điểm tích",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(width: 20,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${list[0]['SDT']}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 50,),
                                  Text("${list[0]['HoTen']}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 50,),
                                  Text("${list[0]['Email']}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 50,),
                                  Text("${list[0]['DiaChi']}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 50,),
                                  Text("${list[0]['Vip']==true?'VIP':'Thường'}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 50,),
                                  Text("${list[0]['DiemTich']}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 40,),
                          Container(
                            height: 177,
                            width: 421,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              border: Border(
                                top: BorderSide(style: BorderStyle.solid,color: Colors.black,width: 2),
                                bottom: BorderSide(style: BorderStyle.solid,color: Colors.black,width: 2),
                              ),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 20,),
                                ElevatedButton(
                                    onPressed: () {

                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        padding: const EdgeInsets.only(right: 103, left: 103, top: 20, bottom: 20),
                                        shape: const RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Colors.black,
                                              width: 2,
                                            )
                                        )
                                    ),
                                    child: const Text("Cập nhật thông tin", style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20
                                    ))
                                ),
                                SizedBox(height: 20,),
                                ElevatedButton(
                                    onPressed: () {
                                        Get.to(QuanLySanBongApp());
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        padding: const EdgeInsets.only(right: 140, left: 140, top: 10, bottom: 10),
                                        shape: const RoundedRectangleBorder(
                                            side: BorderSide(
                                              color: Colors.black,
                                              width: 2,
                                            )
                                        )
                                    ),
                                    child: const Text("Đăng xuất", style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20
                                    ))
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: Colors.green,),
            label: "Trang chủ",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle,color: Colors.green),
            label: "Tài khoản",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined,color: Colors.green),
            label: "Lịch sử",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper,color: Colors.green),
            label: "Tin tức",
          ),
        ],
        type: BottomNavigationBarType.shifting,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        selectedItemColor: Colors.green,
        currentIndex: 1,
        iconSize: 40,
        onTap: (value) {
          indexBar = value;
          setState(() {

          });
          switch(value){
            case 0: Navigator.push(context,
                MaterialPageRoute(builder: (context) => FirebaseHome(maTK: maTK),)); break;
            case 1: Navigator.push(context,
                MaterialPageRoute(builder: (context) => FireBaseAccount(maTK: maTK),)); break;
            case 2: Navigator.push(context,
                MaterialPageRoute(builder: (context) => FireBaseHistory(maTK: maTK),)); break;
            case 3: Navigator.push(context,
                MaterialPageRoute(builder: (context) => PageRss(maTK: maTK),)); break;
          }
        },
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    maTK = widget.maTK;
  }
}



