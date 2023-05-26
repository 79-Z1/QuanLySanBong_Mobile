import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quanlysanbong/Authen/RegisterPage.dart';
import 'package:get/get.dart';
import 'package:quanlysanbong/Firebase/TaiKhoan_Controller.dart';
import 'package:quanlysanbong/Home/HomePage.dart';
import '../Firebase/Connect_Firebase.dart';

class QuanLySanBongApp extends StatelessWidget {
  const QuanLySanBongApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(
        builder: (context) => PageLogin(),
        errorMessage: "Lỗi kết nối với firebase!",
        connectingMessage: "Vui lòng đợi kết nối!"
    );
  }
}

class PageLogin extends StatelessWidget {
  PageLogin({Key? key}) : super(key: key);
  TextEditingController txtTenTK = TextEditingController();
  TextEditingController txtMK = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  Widget inputField(String text,Widget icon, TextEditingController txt, String displayText, bool typePassword){
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
                  SizedBox(height: 100,),
                  Text("Đăng nhập",style: TextStyle(color: Colors.white,fontSize: 50),),
                  inputField("Email",Icon(Icons.email),txtTenTK,"Chưa nhập email",false),
                  inputField("Mật khẩu",Icon(Icons.lock,),txtMK,"Chưa nhập mật khẩu",true),
                  Container(
                    height:50,
                    child: ElevatedButton(
                        onPressed: () async{
                          ktform(context);
                          await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: txtTenTK.text.trim(),
                              password: txtMK.text.trim()
                          );
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage(maTK: "TK003",)));
                        },
                        child: Text("Đăng nhập",style: TextStyle(fontSize: 20),)),
                  ),
                  Spacer(),
                  TextButton(onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PageRegister()));
                  }, child: Text("Chưa có tài khoản?",style: TextStyle(fontSize: 20,color: Colors.white),)
                  ),
                  Container(
                    height: 70,
                    padding: EdgeInsets.symmetric(horizontal: 30,vertical: 8),
                    child: ElevatedButton(onPressed: () {
                    },child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.tiktok),
                        SizedBox(width: 40),
                        Text(("Tiếp tục với Google"),style: TextStyle(fontSize: 22),)
                      ],
                    )),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  String? validateString(String? s, {required String displayText}){
    return s == null || s.isEmpty ? displayText : null;
  }
  ktform(BuildContext context){
    if(formState.currentState?.validate() == true){
      formState.currentState?.save();
    }
  }
}

