import 'package:flutter/material.dart';
import 'package:quanlysanbong/Account/AccountPage.dart';
import 'package:quanlysanbong/History/HistoryPage.dart';
import 'package:quanlysanbong/Home/HomePage.dart';
import 'package:quanlysanbong/Rss/Page/PageRss.dart';

import '../Firebase/Connect_Firebase.dart';

class FirebaseMain extends StatelessWidget {
  String? maTK;
  FirebaseMain({Key? key, required this.maTK}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(
        builder: (context) => PageMain(maTK: this.maTK),
        errorMessage: "Lỗi kết nối với Firebase!",
        connectingMessage: "Vui lòng đợi kết nối!"
    );
  }
}

class PageMain extends StatefulWidget {
  String? maTK;
  PageMain({Key? key, required this.maTK}) : super(key: key);

  @override
  State<PageMain> createState() => _PageMainState();
}

class _PageMainState extends State<PageMain> {
  String? maTK;
  int indexBar = 0;
  late final screen = [
    FirebaseHome(maTK: maTK),
    FireBaseAccount(maTK: maTK),
    FireBaseHistory(maTK: maTK),
    PageRss(maTK: maTK),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[indexBar],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Trang chủ",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Tài khoản",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            label: "Lịch sử",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: "Tin tức",
          ),
        ],
        type: BottomNavigationBarType.shifting,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        selectedItemColor: Colors.green,
        unselectedIconTheme: IconThemeData(color: Colors.grey),
        currentIndex: indexBar,
        iconSize: 40,
        onTap: (value) {
          setState(() {
            indexBar = value;
          });
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
