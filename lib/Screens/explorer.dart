import'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';
class Webview extends StatefulWidget {
  const Webview({Key? key}) : super(key: key);

  @override
  State<Webview> createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {

  @override
  void initState() {
    super.initState();
   // if (Platform.isAndroid) WebView.platform = AndroidWebView();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: const WebView(
        initialUrl: 'https://zenscape.one/',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}