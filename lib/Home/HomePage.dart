import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:quanlysanbong/Firebase/ChiTietSan.dart';
import 'package:quanlysanbong/Firebase/Connect_Firebase.dart';
import 'package:quanlysanbong/Firebase/San_Data.dart';
import 'package:quanlysanbong/History/HistoryPage.dart';
import 'package:webview_flutter/webview_flutter.dart';

List<String> banners = [
  "asset/images/banner/banner1.jpg",
  "asset/images/banner/banner2.png",
  "asset/images/banner/banner3.png",
  "asset/images/banner/banner4.png",
  "asset/images/banner/banner5.png",
];

class MyFirebaseHome extends StatelessWidget {
  const MyFirebaseHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(
        builder: (context) => HomePage(),
        errorMessage: "Lỗi kết nối với Firebase!",
        connectingMessage: "Vui lòng đợi kết nối!"
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int indexBar = 0;
  int imgPos = 0;
  String userName = "Trương Khánh Hòa";
  Timer? countdownTimer;
  String time = DateFormat("HH:mm:ss").format(DateTime.now());
  late final WebViewController controller;

  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }
  void setCountDown() {
    setState(() {
      time = DateFormat("HH:mm:ss").format(DateTime.now());
    });
  }


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
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
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
            SizedBox(height: 20,),
            Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  style:BorderStyle.solid,
                  width: 3,
                ),
              ),
              child: CarouselSlider.builder(
                options: CarouselOptions(
                  autoPlay: true,
                  viewportFraction: 1,
                  initialPage: imgPos,
                  onPageChanged: (index, reason) {
                    setState(() {
                      imgPos = index;
                    });
                  },
                ),
                itemCount: banners.length,
                itemBuilder: (context, index, realIndex) => Container(
                  child: Image.asset(banners[index]),
                ),
              ),
            ),
            SizedBox(height: 5,),
            Text("${time}",
              style: TextStyle(
                fontSize: 45,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    style:BorderStyle.solid,
                    width: 3,
                  ),
                ),
                child: WebViewWidget(
                  controller: controller,
                ),
              ),
            ),
            SizedBox(height: 5,),
            StreamBuilder(
              stream: SanSnapShot.getAll(),
              builder: (context, snapshot) {
                if(snapshot.hasError){
                  print(snapshot.error);
                  return Center(
                    child: Text("Lỗi dữ liệu Firebase",
                      style: TextStyle(
                          color: Colors.red),
                    ),
                  );
                }
                else
                if(!snapshot.hasData){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else
                {
                  var list = snapshot.data!;
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => SizedBox(height: 5,),
                    itemBuilder: (context, index) => Container(
                      child: Image.network("${list[index].san!.Anh}"),
                    ),
                    itemCount: list.length,
                  );
                  // return Container(
                  //   child: Image.network("${list[0].san!.Anh}"),
                  // );
                }
              },
            ),
          ],
        ),
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
          switch(value){
            case 0: Navigator.push(context,
                MaterialPageRoute(builder: (context) => PageHistory(),)); break;
            case 1: Navigator.push(context,
                MaterialPageRoute(builder: (context) => PageHistory(),)); break;
            case 2: Navigator.push(context,
                MaterialPageRoute(builder: (context) => PageHistory(),)); break;
            case 3: Navigator.push(context,
                MaterialPageRoute(builder: (context) => PageHistory(),)); break;
          }
        },
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://www.accuweather.com/vi/vn/nha-trang/354222/weather-forecast/354222'));
  }
}