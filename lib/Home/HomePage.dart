import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:quanlysanbong/Account/AccountPage.dart';
import 'package:quanlysanbong/Booking/BookingPage.dart';
import 'package:quanlysanbong/Firebase/Connect_Firebase.dart';
import 'package:quanlysanbong/Firebase/JoinTable.dart';
import 'package:quanlysanbong/Firebase/San_Data.dart';
import 'package:quanlysanbong/History/HistoryPage.dart';
import 'package:quanlysanbong/Rss/Page/PageRss.dart';
import 'package:webview_flutter/webview_flutter.dart';

List<String> banners = [
  "asset/images/banner/banner1.jpg",
  "asset/images/banner/banner2.png",
  "asset/images/banner/banner3.png",
  "asset/images/banner/banner4.png",
  "asset/images/banner/banner5.png",
];

class FirebaseHome extends StatelessWidget {
  String? maTK;
  FirebaseHome({Key? key, required this.maTK}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(
        builder: (context) => HomePage(maTK: this.maTK),
        errorMessage: "Lỗi kết nối với Firebase!",
        connectingMessage: "Vui lòng đợi kết nối!"
    );
  }
}

class HomePage extends StatefulWidget {
  String? maTK;
  HomePage({Key? key, required this.maTK}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? maTK;
  int indexBar = 0;
  int imgPos = 0;
  Timer? countdownTimer;
  String time = DateFormat("HH:mm:ss").format(DateTime.now());
  late final WebViewController controller;

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
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
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.account_circle,size: 60,color: Colors.white,),
                  const SizedBox(width: 5,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Xin chào",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white
                        ),
                      ),
                      StreamBuilder(
                          stream: JoinTable.TaiKhoanFromMaTK(maTK!),
                          builder: (context, snapshot) {
                              if(snapshot.hasError){
                                print(snapshot.error);
                                return const Center(
                                  child: Text("Lỗi dữ liệu Firebase",
                                    style: TextStyle(
                                        color: Colors.red),
                                  ),
                                );
                              }
                              else
                              if(!snapshot.hasData){
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              else
                              {
                                var list = snapshot.data!;
                                return Text("${list[0]['HoTen']}",
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)
                                );
                              }
                            },
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              width: 406,
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
            const SizedBox(height: 5,),
            Text("${time}",
              style: const TextStyle(
                fontSize: 45,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                padding: const EdgeInsets.all(3),
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
            const SizedBox(height: 5,),
            StreamBuilder(
              stream: SanSnapShot.getAll(),
              builder: (context, snapshot) {
                if(snapshot.hasError){
                  print(snapshot.error);
                  return const Center(
                    child: Text("Lỗi dữ liệu Firebase",
                      style: TextStyle(
                          color: Colors.red),
                    ),
                  );
                }
                else
                if(!snapshot.hasData){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else
                {
                  var list = snapshot.data!;
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => const SizedBox(height: 10,),
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: Colors.black,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Image.asset("${list[index].san!.Anh}"),
                            Container(
                              child: Column(
                                children: [
                                  const SizedBox(height: 150,),
                                  Row(
                                    children: [
                                      const SizedBox(width: 10,),
                                      const Icon(Icons.location_on,color: Colors.white,),
                                      Container(
                                        width: 220,
                                          child: Text("${list[index].san!.DiaChi}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold
                                              ),
                                          ),
                                      ),
                                      const SizedBox(width: 10,),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => FireBaseBooking(maTK: maTK, maSan: "${list[index].san!.MaSan}",)));
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green,
                                              padding: const EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
                                              shape: const RoundedRectangleBorder(
                                                  side: BorderSide(
                                                    width: 2,
                                                      color: Colors.black
                                                  )
                                              )
                                          ),
                                          child: const Text("Đặt sân ngay", style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15
                                          ))
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    maTK = widget.maTK;
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