import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quanlysanbong/Authen/LoginPage.dart';
import 'package:quanlysanbong/Firebase/TaiKhoan_Data.dart';


class PageRegister extends StatelessWidget {
  PageRegister({Key? key}) : super(key: key);
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtmatkhau = TextEditingController();
  TextEditingController txtxacnhanmatkhau = TextEditingController();
  TextEditingController txttentk = TextEditingController();
  TextEditingController txthoten = TextEditingController();
  TextEditingController txtsdt = TextEditingController();
  TextEditingController txtdiachi = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  Widget inputField(String text,Widget icon, TextEditingController txt, String displayText,bool typePassword){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 8),
      child: TextFormField(
        obscureText: typePassword,
        controller: txt,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: text,
            labelStyle: TextStyle(
                color: Colors.green,fontSize: 20,fontWeight: FontWeight.bold
            ),
            prefixIcon: icon,
            prefixIconColor: Colors.green
        ),
        validator: (value) => validateString(
            value,
            displayText: displayText
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: formState,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("asset/images/login/backgroundqlsb.jpg"),
                      fit: BoxFit.cover
                  )
              ),
            ),
            Container(
              child: Column(
                children: [
                  SizedBox(height: 35,),
                  Text("Đăng ký",style: TextStyle(color: Colors.white,fontSize: 50),),
                  inputField("Email",Icon(Icons.email),txtemail,"Chưa nhập email",false),
                  inputField("Mật khẩu",Icon(Icons.lock,),txtmatkhau,"Chưa nhập mật khẩu",true),
                  inputField("Nhập lại mật khẩu",Icon(Icons.lock,),txtxacnhanmatkhau,"Chưa xác nhận mật khẩu",true),
                  inputField("Tên tài khoản",Icon(Icons.person),txttentk,"Chưa nhập tên tài khoản",false),
                  inputField("Họ và tên",Icon(Icons.location_history),txthoten,"Chưa nhập họ và tên",false),
                  inputField("SĐT",Icon(Icons.phone,),txtsdt,"Chưa nhập số điện thoại",false),
                  inputField("Địa chỉ",Icon(Icons.location_on),txtdiachi,"Chưa nhập địa chỉ",false),
                  Container(
                    height:50,
                    child: ElevatedButton(onPressed:() {
                       ktform(context);
                       DiaLogDangKi(context);
                    },
                        child: Text("Đăng Ký",style: TextStyle(fontSize: 20),)),
                  ),
                  Spacer(),
                  TextButton(onPressed: () async{
                    Navigator.pop(context);
                  }, child: Text("Đã có tài khoản?",style: TextStyle(fontSize: 20,color: Colors.white),)
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  bool passwordConfirmed(){
    if(txtxacnhanmatkhau.text.trim() == txtmatkhau.text.trim()){
      return true;
    }
    return false;
  }
  String? validateString(String? s, {required String displayText}){
    return s == null || s.isEmpty ? displayText : null;
  }
  ktform(BuildContext context){
    if(formState.currentState?.validate() == true){
      formState.currentState?.save();
    }
  }
  _DkTaiKhoan(TaiKhoan tk){
    TaiKhoanSnapShot.themMoi(tk);
  }

  Future DiaLogDangKi(BuildContext context) async{
    if(passwordConfirmed() == false){
      var dialog = AlertDialog(
        title: Text("Thông báo"),
        content: Container(
          child: Text("Xác nhận mật khẩu không đúng"),
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Nhập lại")
          )
        ],
      );
      showDialog(context: context, builder: (context) => dialog);
    }else{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: txtemail.text.trim(),
          password: txtmatkhau.text.trim()
      );
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("TaiKhoan").get();
      int documentCount = querySnapshot.size + 1;
      String userId = 'TK${documentCount.toString().padLeft(3, '0')}';
      TaiKhoan tk = TaiKhoan(
          MaTK: userId,
          HoTen: txthoten.text.trim(),
          TenTK: txttentk.text.trim(),
          MatKhau: txtmatkhau.text.trim(),
          SDT: txtsdt.text.trim(),
          Email: txtemail.text.trim(),
          DiaChi: txtdiachi.text.trim(),
          DiemTich: 0,
          Quyen: false,
          Vip: false
      );
      _DkTaiKhoan(tk);
      var dialog = AlertDialog(
        title: Text("Thông báo"),
        content: Container(
          child: Text("Bạn đã đăng kí thành công"),

        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Ok")
          )
        ],
      );
      showDialog(context: context, builder: (context) => dialog);
    }
  }
}
