import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanlysanbong/Home/HomePage.dart';
import 'package:quanlysanbong/Rss/Controller/RssController.dart';
import 'package:quanlysanbong/Rss/Page/WebView.dart';

class PageRss extends StatelessWidget {
  const PageRss({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ControllerRss());
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
                        Get.to(FirebaseHome(maTK: 'TK004',));
                      },
                    ),
                    SizedBox(width: 103,),
                    Text("Lịch sử", style: TextStyle(fontSize: 30, color: Colors.white))
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
                                border: Border.all(color: Colors.green,width: 4),

                              ),
                              child: GestureDetector(
                                onTap: () => Get.to(MyWebPage(url: "${listRSS[index].link}")),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Text("${listRSS[index].title}",style: TextStyle(fontSize: 20,color: Colors.blue)),
                                      SizedBox(height: 10,),
                                      _getImage(listRSS[index].imageUrl),
                                      SizedBox(height: 10,),
                                      Text("${listRSS[index].description}")
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
    );
  }
  Widget _getImage(String? url){
    if(url != null)
      return Image.network(url, fit: BoxFit.fitWidth);
    return Center(
      child: Column(
        children: [
          Icon(Icons.image),
          Text("No Image!")
        ],
      ),
    );
  }
}
