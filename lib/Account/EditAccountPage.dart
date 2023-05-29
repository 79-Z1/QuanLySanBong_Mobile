import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanlysanbong/Firebase/Connect_Firebase.dart';
import 'package:quanlysanbong/Firebase/JoinTable.dart';
import 'package:quanlysanbong/Firebase/TaiKhoan_Data.dart';
import 'package:quanlysanbong/History/HistoryPage.dart';
import 'package:quanlysanbong/Home/HomePage.dart';
import 'package:quanlysanbong/Rss/Page/PageRss.dart';

import 'AccountPage.dart';

class FireBaseEditAccount extends StatelessWidget {
  String? maTK;
  FireBaseEditAccount({Key? key, required this.maTK}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(
        builder: (context) => PageEditAccount(maTK: this.maTK),
        errorMessage: "Lỗi kết nối với firebase!",
        connectingMessage: "Vui lòng đợi kết nối!"
    );
  }
}
class PageEditAccount extends StatefulWidget {
  String? maTK;
  PageEditAccount({Key? key , required this.maTK}) : super(key: key);
  @override
  State<PageEditAccount> createState() => _PageEditAccountState();
}

class _PageEditAccountState extends State<PageEditAccount> {
  String? maTK;
  int indexBar = 1;
  @override
  TextEditingController txtsdt = TextEditingController();
  TextEditingController txtname = TextEditingController();
  TextEditingController txtdiachi = TextEditingController();
  Widget build(BuildContext context) {
    int indexBar = 0;
    // var screenHeight = MediaQuery.of(context).size.height;
    // var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => FireBaseAccount(maTK: maTK),));
                    Navigator.pop(context);
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
                StreamBuilder<TaiKhoanSnapShot>(
                  stream: TaiKhoanSnapShot.getTKByMaTk(maTK!),
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
                          SizedBox(height: 31,),
                          Row(
                            children: [
                              SizedBox(width: 30,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 30,),
                                  Container(
                                    height: 50,
                                    child: Text("Số điện thoại",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Container(
                                    height: 50,
                                    child: Text("Họ tên",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Container(height: 50,
                                    child: Text("Địa chỉ",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Container(height: 50,
                                    child: Text("Email",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 40,),
                                  Container(height: 50,
                                    child: Text("Thành viên",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Container(height: 50,
                                    child: Text("Điểm tích",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 20,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //SizedBox(height: 25,),
                                    SizedBox(
                                      height: 35,
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 5)
                                        ),
                                        controller: txtsdt,
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                                    SizedBox(height: 28,),
                                    SizedBox(
                                      height: 35,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 5)
                                        ),
                                        controller: txtname,
                                        keyboardType: TextInputType.text,
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                                    SizedBox(height: 28,),
                                    SizedBox(
                                      height: 45,
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 5)
                                        ),
                                        controller: txtdiachi,
                                        keyboardType: TextInputType.text,
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                                    SizedBox(height: 25,),
                                    Text("${list.taiKhoan!.Email}",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 37,),
                                    Text("${list.taiKhoan!.Vip==true?'VIP':'Thường'}",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 37,),
                                    Text("${list.taiKhoan!.DiemTich}",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 20,),
                            ],
                          ),
                          SizedBox(height: 40,),
                          Container(
                            height: 160,
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
                                SizedBox(height: 45,),
                                ElevatedButton(
                                    onPressed: () {
                                      _capNhat(context);
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
                                    child: const Text("Lưu", style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20
                                    ))
                                ),
                                SizedBox(height: 20,),
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
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    maTK = widget.maTK;
    FirebaseFirestore.instance.collection('TaiKhoan').where('MaTK', isEqualTo: maTK).get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        txtsdt.text = doc["SDT"];
        txtname.text = doc["HoTen"];
        txtdiachi.text = doc["DiaChi"];
      });
    });
  }
  _capNhat(BuildContext context) async{
    showSnackbar(context, "Đang cập nhật dữ liệu....");
    TaiKhoan tk = TaiKhoan.update(
      SDT: txtsdt.text.trim(),
      HoTen: txtname.text.trim(),
      DiaChi: txtdiachi.text.trim()
    );
    _capNhatTaikhoan(tk);
  }
  _capNhatTaikhoan(TaiKhoan tk) async{
    TaiKhoan tk = TaiKhoan.update(
        SDT: txtsdt.text.trim(),
        DiaChi: txtdiachi.text.trim(),
        HoTen: txtname.text.trim()
    );
    FirebaseFirestore.instance
        .collection('TaiKhoan')
        .where('MaTK', isEqualTo: maTK)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((documentSnapshot) {
        documentSnapshot.reference.update({
          'SDT': txtsdt.text,
          'HoTen': txtname.text,
          'DiaChi': txtdiachi.text,
        }).whenComplete(() => showSnackbar(context,"Cập nhật dữ liệu thành công"))
            .onError((error, stackTrace) => showSnackbar(context,"Cập nhật dữ liệu không thành công"));
      });
    });
  }
  void showSnackbar(BuildContext context,  String message){
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: Duration(seconds: 2),
        )
    );
  }
}




