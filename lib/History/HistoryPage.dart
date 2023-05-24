import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:quanlysanbong/Firebase/Connect_Firebase.dart';
import 'package:quanlysanbong/Firebase/DatSan_Data.dart';
import 'package:quanlysanbong/Firebase/Test.dart';

class FireBaseHistory extends StatelessWidget {
  const FireBaseHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(
        builder: (context) => PageHistory(),
        errorMessage: "Lỗi kết nối với firebase!",
        connectingMessage: "Vui lòng đợi kết nối!"
    );
  }
}

class PageHistory extends StatefulWidget {
  const PageHistory({Key? key}) : super(key: key);

  @override
  State<PageHistory> createState() => _PageHistoryState();
}

class _PageHistoryState extends State<PageHistory> {
  @override
  Widget build(BuildContext context) {
    int indexBar = 0;
    // var screenHeight = MediaQuery.of(context).size.height;
    // var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 30),
              color: Colors.green,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(width: 20, height: 20),
                  InkWell(

                    child: Icon(
                      CupertinoIcons.arrow_left_circle_fill,
                      color: Colors.white,
                      size: 40,
                    )
                  ),
                  Spacer(),
                  Text("Lịch sử", style: TextStyle(fontSize: 30, color: Colors.white))
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
                  ElevatedButton(
                    onPressed: () {

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen,
                      padding: const EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
                      shape: const StadiumBorder(
                        side: BorderSide(
                          color: Colors.black
                        )
                      )
                    ),
                    child: const Text("Đặt sân", style: TextStyle(color: Colors.black, fontSize: 20))
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                      color: Colors.black, thickness: 2,
                  ),
                  StreamBuilder<List<dynamic>>(
                    stream: San_DatSan.joinChiTietSanVaDatSanVaSan(),
                    builder: (context, snapshot) {
                      if(snapshot.hasError) {
                        print("Lỗi nè");
                        print(snapshot.error);
                        return const Center(
                          child: Text("Lỗi dữ liệu Firebase",
                            style: TextStyle(
                                color: Colors.red),
                          ),
                        );
                      } else if(!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        var list = snapshot.data!;
                        print(list.length);
                        return Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) => Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(width: 2)
                              ),
                              child: Column(
                                children: [
                                  Row(
                                      children: const [
                                        Text("Sân bóng đá sao việt", style: TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold
                                        )),
                                        Spacer(),
                                        Text("Đang đặt", style: TextStyle(color: Colors.green))
                                      ]
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Image.asset("", height: 100,width: 50),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          const Text("Sân 1", style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold
                                          )),
                                          Row(
                                            children: const [
                                              Text("Khung giờ:", style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold
                                              )),
                                              SizedBox(width: 10,),
                                              Text("12h - 15h", style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold
                                              )),
                                            ],
                                          ),
                                          Row(
                                            children: const [
                                              Text("Thành tiền:", style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold
                                              )),
                                              SizedBox(width: 10,),
                                              Text("500.000đ", style:TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold
                                              )),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {

                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.yellow,
                                              padding: const EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
                                              shape: const RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      color: Colors.black
                                                  )
                                              )
                                          ),
                                          child: const Text("Chỉnh sửa", style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15
                                          ))
                                      ),
                                      const SizedBox(width: 10),
                                      ElevatedButton(
                                          onPressed: () {

                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                              padding: const EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
                                              shape: const RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      color: Colors.black
                                                  )
                                              )
                                          ),
                                          child: const Text("Hủy sân", style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15
                                          ))
                                      )
                                    ],
                                  )
                                ],
                              )
                            ),
                            separatorBuilder: (context, index) => const SizedBox(height: 10),
                            itemCount: list.length
                          ));
                      }
                    },
                  )
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home,color: Colors.grey,),
              label: "Trang chủ",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle,color: Colors.grey),
              label: "Tài khoản",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history_outlined,color: Colors.grey),
              label: "Lịch sử",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.newspaper,color: Colors.grey),
              label: "Tin tức",
            ),
          ],
          type: BottomNavigationBarType.shifting,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
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
