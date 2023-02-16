import'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';
class Webview extends StatefulWidget {
  final String Url;
  const Webview({Key? key,required this.Url}) : super(key: key);

  @override
  State<Webview> createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {

  @override
  void initState() {
    super.initState();
   // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebView(
        initialUrl: widget.Url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}