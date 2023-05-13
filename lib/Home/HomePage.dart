import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int indexBar = 0;
  String userName = "Trương Khánh Hòa";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 80,
              decoration: BoxDecoration(
                  color: Colors.green,

              ),
              child: Row(
                children: [
                  Icon(Icons.account_circle,size: 50,color: Colors.white,),
                  SizedBox(width: 5,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Xin chào",
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.white
                        ),
                      ),
                      Text("${userName}",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        )
        ,
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: [
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
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          selectedItemColor: Colors.green,
          currentIndex: indexBar,
          iconSize: 40,
          onTap: (value) {
            indexBar = value;
            setState(() {

            });
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