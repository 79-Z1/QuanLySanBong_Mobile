import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quanlysanbong/Rss/Model/RssItem.dart';
import 'package:xml2json/xml2json.dart';

String _rssUrlVNExpress="https://thethao247.vn/bong-da-viet-nam-c1.rss";
String reSourceName="Tin tức bóng đá";

class ControllerRss extends GetxController{
  final _rssList = <RSSItem>[].obs;
  List<RSSItem> get rssList => _rssList.value;
  @override
  void onInit() {
    // TODO: implement onInit
    readRss();
  }
  Future<List<dynamic>?> _fetchRSS(String rssURL) async{
    final response = await http.get(Uri.parse(rssURL));
    if(response.statusCode == 200) {
      final xml2Json = Xml2Json();
      xml2Json.parse(utf8.decode(response.bodyBytes)); //Phân tích nội dung xml của rss
      var rssJson = xml2Json.toParker(); //Chuyển nội dung xml của rss thành chuỗi Json
      Map<String, dynamic> jsonData = jsonDecode(rssJson); //Chuyển chuỗi Json thành đối tượng Map
      return (jsonData["rss"]["channel"]["item"]); // Trả về danh sách các Rss Item dạng Map
    }
    return Future.error("Lỗi đọc Rss");
  }
  Future<void> readRss() async{
    _fetchRSS(_rssUrlVNExpress)
        .then((value) {
      _rssList.value = value?.map(
              (rssMap) => RSSItem.resournameOnly(rssReSourceName: reSourceName)
              .getFromJson(rssMap)
      ).toList() ?? [];
      _rssList.refresh();
      print(rssList[1].description);
    }).catchError((error){
      print(error);
    }
    );
  }
}