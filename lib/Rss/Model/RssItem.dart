Map<String,String> descriptionMap = {
  "Tin tức bóng đá_start": "</a>",
  "Tin tức bóng đá_end": "",
};
String startPatternImage = '<img src="';
String endPatternImage = '"';
class RSSItem{
  String rssReSourceName;
  String? title;
  String? pubDate;
  String? description;
  String? link;
  String? imageUrl;

  String get startPatternDescription => descriptionMap[rssReSourceName + "_start"] as String;
  String get endPatternDescription => descriptionMap[rssReSourceName + "_end"] as String;

  RSSItem.resournameOnly({
    required this.rssReSourceName,
  });

  RSSItem getFromJson(Map<String, dynamic> json) {
    title= json['title'];
    pubDate= json['pubDate'];
    description= _getDescription(json['description']);
    link= json['link'];
    imageUrl= _getImageUrl(json['description']);
    return this;
  }

  String _getDescription(String rawDescription){
    int start = rawDescription.indexOf(startPatternDescription) + startPatternDescription.length;
    if(start > startPatternDescription.length){
      if(endPatternDescription.length > 0){
        int end = rawDescription.indexOf(endPatternDescription, start);
        return rawDescription.substring(start,end);
      }
      return rawDescription.substring(start);
    }
    return "";
  }

  String? _getImageUrl(String rawDescription){
    int start = rawDescription.indexOf(startPatternImage) + startPatternImage.length;
    if(start > startPatternImage.length){
      if(endPatternImage.length > 0){
        int end = rawDescription.indexOf(endPatternImage, start);
        return rawDescription.substring(start,end);
      }
      return rawDescription.substring(start);
    }
    return null;
  }

}