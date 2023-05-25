import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebPage extends StatefulWidget {
  String url;
  MyWebPage({Key? key, required this.url}) : super(key: key);

  @override
  State<MyWebPage> createState() => _MyWebPageState();
}

class _MyWebPageState extends State<MyWebPage> {
  late final WebViewController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tin tức bóng đá"),),
      body: WebViewWidget(controller: controller,),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      ..loadRequest(Uri.parse(widget.url));
  }
}
