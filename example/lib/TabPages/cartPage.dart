import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CartTabPage extends StatelessWidget {
   String url = "https://www.google.com";

  CartTabPage({ this.url});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WebView(
          initialUrl:"https://www.gravitylifestyle.com.np/",
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
