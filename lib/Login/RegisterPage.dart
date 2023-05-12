import 'package:flutter/material.dart';
import 'package:quanlysanbong/Login/LoginPage.dart';

class PageRegister extends StatelessWidget {
  const PageRegister({Key? key}) : super(key: key);
  Widget inputField(String text,Widget icon){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 8),
      child: TextField(
        decoration: InputDecoration(
            enabled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.green,width: 2.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.green,width: 2.5),
            ),
            filled: true,
            fillColor: Colors.white,
            labelText: text,
            labelStyle: TextStyle(
                color: Colors.green,fontSize: 20,fontWeight: FontWeight.bold
            ),
            prefixIcon: icon,
            prefixIconColor: Colors.green
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                Text("Đăng ký",style: TextStyle(color: Colors.white,fontSize: 50),),
                inputField("Email",Icon(Icons.email)),
                inputField("Mật khẩu",Icon(Icons.lock,)),
                inputField("SĐT",Icon(Icons.lock,)),
                Container(
                  height:50,
                  child: ElevatedButton(onPressed: () {

                  }, child: Text("Đăng Ký",style: TextStyle(fontSize: 20),)),
                ),
                Spacer(),
                TextButton(onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => PageLogin()));
                }, child: Text("Đã có tài khoản?",style: TextStyle(fontSize: 20,color: Colors.white),)
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
