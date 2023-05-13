import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

String _rssURLVNExpress = "https://thethao247.vn/bong-da.rss";
void main()async{
  final response = await http.get(Uri.parse(_rssURLVNExpress));
  if(response.statusCode == 200){
    print(response.body);
    final xml2Json = Xml2Json();
    xml2Json.parse(utf8.decode(response.bodyBytes));//Phân tích nội dung xml của rss
    var rssJson = xml2Json.toParker();//Chuyển nội dung xml của rss thành chuỗi Json
    Map<String,dynamic> jsonData = jsonDecode(rssJson);//Chuyển chuỗi Json thành đối tượng Map
    var testData = jsonData["rss"]["channel"]["item"][0];
    // print(testData['title']);
    // print(testData['link']);
    // print(testData['description']);
    // print(testData['pubDate']);
    return (jsonData["rss"]["channel"]["item"]);// Trả về danh sách các Rss Item dạng Map
  }
}