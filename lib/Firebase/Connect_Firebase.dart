import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'TaiKhoan_Data.dart';


class MyFirebaseConnect extends StatefulWidget {
  final String? errorMessage;
  final String? connectingMessage;
  final Widget Function(BuildContext context)? builder;
  const MyFirebaseConnect({Key? key,
    required this.builder,
    required this.errorMessage,
    required this.connectingMessage
  }) : super(key: key);

  @override
  State<MyFirebaseConnect> createState() => _MyFirebaseConnectState();
}

class _MyFirebaseConnectState extends State<MyFirebaseConnect> {
  bool ketNoi = false;
  bool loi = false;
  @override
  Widget build(BuildContext context) {
    if(loi){
      return
        Container(
          color: Colors.white,
          child: Center(
            child: Text(widget.errorMessage!,
              style: TextStyle(fontSize: 16,),
              textDirection: TextDirection.ltr,
            ),
          ),
        );
    }
    else{
      if(!ketNoi){
        return
          Container(
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment:  MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text(widget.connectingMessage!,
                    style: TextStyle(fontSize: 16),
                    textDirection: TextDirection.ltr,
                  ),
                ],
              ),
            ),
          );
      }
      else{
        return
          widget.builder!(context);
      }
    }

  }
  _khoiTaoFirebase(){
    Firebase.initializeApp()
        .then((value) {
      setState(() {
        ketNoi = true;
      });
    })
        .catchError((error){
      print(error);
      setState(() {
        loi = true;
      });
    })
        .whenComplete(() => print("Kết thúc việc khởi tạo Firebase")); //Finaly
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _khoiTaoFirebase();
  }
}
