import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int indexBar = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Trang chủ"),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: "Tài khoản"),
          BottomNavigationBarItem(icon: Icon(Icons.history_rounded), label: "Lịch sử"),
          // BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: "Tin tức"),
        ],
        currentIndex: indexBar,
        onTap: (value) {
          indexBar = value;
          setState(() {
          });
          switch(value){
            case 0: _showSnackbar(context, "Bạn mở Inbox"); break;
            case 1: _showSnackbar(context, "Bạn mở Contacts"); break;
            case 2: _showSnackbar(context, "Bạn mở Calender"); break;
            case 3: _showSnackbar(context, "Bạn mở Calender"); break;
          }
        },
      ),
    );
  }
}
void _showSnackbar(BuildContext context, String message){
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 5),
        backgroundColor: Colors.grey[600],
      )
  );
}