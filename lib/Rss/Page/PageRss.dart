import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanlysanbong/Home/HomePage.dart';
import 'package:quanlysanbong/Rss/Controller/RssController.dart';
import 'package:quanlysanbong/Rss/Page/WebView.dart';

import '../../Account/AccountPage.dart';
import '../../History/HistoryPage.dart';

class PageRss extends StatefulWidget {
  PageRss({Key? key,required this.maTK}) : super(key: key);
  String? maTK;
  @override
  State<PageRss> createState() => _PageRssState();
}

class _PageRssState extends State<PageRss> {
  String? maTK;
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ControllerRss());
    int indexBar = 0;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 30),
            color: Colors.green,
            child: Column(
              children:[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 20, height: 20),
                    InkWell(
                      child: const Icon(
                        CupertinoIcons.arrow_left_circle_fill,
                        color: Colors.white,
                        size: 40,
                      ),
                      onTap: () {
                        Navigator.pop(context,
                          //MaterialPageRoute(builder: (context) => FirebaseHome(maTK: maTK),)
                        );
                      },
                    ),
                    SizedBox(width: 103,),
                    Text("Tin tức", style: TextStyle(fontSize: 30, color: Colors.white))
                  ],
                ),
              ]
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 80),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            // color: Colors.red,
            child: RefreshIndicator(
              onRefresh: () => controller.readRss(),
              child: GetX<ControllerRss>(
                init: controller,
                builder: (controller){
                  var listRSS = controller.rssList;
                  return Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: ListView.separated(
                        itemBuilder: (context, index) => Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.green,width: 2),
                              ),
                              child: GestureDetector(
                                onTap: () => Get.to(MyWebPage(url: "${listRSS[index].link}",maTK: maTK,)),
                                child: Padding(
                                  padding: EdgeInsets.all(7),
                                  child: Row(
                                    children: [
                                      _getImage(listRSS[index].imageUrl),
                                      SizedBox(width:10,),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text("${listRSS[index].title}",style: TextStyle(fontSize: 16,color: Colors.blue)),
                                            Text("${listRSS[index].description}",style: TextStyle(fontSize: 13),)
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        separatorBuilder: (context, index) => SizedBox(height: 10,),
                        itemCount: listRSS.length
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
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
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        selectedItemColor: Colors.green,
        currentIndex: 3,
        iconSize: 40,
        onTap: (value) {
          indexBar = value;
          setState(() {

          });
          switch(value){
            case 0: Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) => FirebaseHome(maTK: maTK),),(route) => false,
            ); break;
            case 1: Navigator.push(context,
                MaterialPageRoute(builder: (context) => FireBaseAccount(maTK: maTK),)); break;
            case 2: Navigator.push(context,
                MaterialPageRoute(builder: (context) => FireBaseHistory(maTK: maTK),)); break;
            case 3: Navigator.push(context,
                MaterialPageRoute(builder: (context) => PageRss(maTK: maTK,),)); break;
          }
        },
      ),
    );
  }

  Widget _getImage(String? url){
    if(url != null)
      return Image.network(url, fit: BoxFit.fitWidth,height: 100,);
    return Center(
      child: Column(
        children: [
          Icon(Icons.image),
          Text("No Image!")
        ],
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
