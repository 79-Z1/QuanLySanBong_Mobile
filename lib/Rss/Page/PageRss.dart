import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanlysanbong/Rss/Controller/RssController.dart';
import 'package:quanlysanbong/Rss/Page/WebView.dart';

class PageRss extends StatelessWidget {
  const PageRss({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ControllerRss());
    return Scaffold(
      appBar: AppBar(
        title: Text(reSourceName),
      ),
      body: RefreshIndicator(
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
                      GestureDetector(
                        onTap: () => Get.to(MyWebPage(url: "${listRSS[index].link}")),
                        child: Row(
                          children: [
                            Expanded(child: _getImage(listRSS[index].imageUrl),flex: 1,),
                            Expanded(child: Text("${listRSS[index].title}",style: TextStyle(fontSize: 20,color: Colors.blue),),
                              flex: 2,
                            )
                          ],
                        ),
                      ),
                      Text("${listRSS[index].description}")
                    ],
                  ),
                  separatorBuilder: (context, index) => Divider(thickness: 1.5,),
                  itemCount: listRSS.length
              ),
            );
          },
        ),
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
