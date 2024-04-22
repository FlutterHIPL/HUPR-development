import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:webview_flutter/webview_flutter.dart';

class WebViewMapScreen extends StatefulWidget {
  const WebViewMapScreen({super.key});

  @override
  State<WebViewMapScreen> createState() => _WebViewMapScreenState();
}

class _WebViewMapScreenState extends State<WebViewMapScreen>{


   late WebViewController controller;



late InAppWebViewController webView;

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
      
        body: 
        
        
        Stack(
          children: [





            InAppWebView(
              initialUrlRequest:
                URLRequest(url:WebUri("https://connect.stripe.com/setup/e/acct_1P64b5Gfizlvjv6i/FJvq4PLvFAB5")),
             initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
allowFileAccessFromFileURLs: true
              )),
              onWebViewCreated: (InAppWebViewController controller) {
                webView = controller;
              },
             androidOnPermissionRequest: (InAppWebViewController controller, String origin, List<String> resources) async {
                    return PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT);
                  },
            androidOnGeolocationPermissionsShowPrompt:
                (InAppWebViewController controller, String origin) async {
              return GeolocationPermissionShowPromptResponse(
                origin: origin,
                allow: true,
                retain: true
              );
              
            },
          )




            // WebView(
            //   initialUrl: "https://www.google.com/maps/dir/?api=1&origin=51.59243420,4.66128150&destination=51.58634780,51.58634780",
            
            //   javascriptMode: JavascriptMode.unrestricted,
            //   onWebViewCreated: (WebViewController webViewController) {
            //  //   _controller.complete(webViewController);
            //     controller=webViewController;
            //   },
            
            //   navigationDelegate: (NavigationRequest request) {
            //     if (request.url.startsWith('intent://maps.app.goo.gl/')) {
            //       print('blocking navigation to $request}');
            //       return NavigationDecision.navigate;
            //     }
            //     print('allowing navigation to $request');
            //     return NavigationDecision.navigate;
            //   },
            //   onPageStarted: (String url) {
            //     print('Page started loading: $url');
            //   },
            //   onPageFinished: (String url) {
            //     print('Page finished loading: $url');
            //   },
            //   gestureNavigationEnabled: true,
            //   gestureRecognizers: Set()
            //     ..add(Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer())),
            // ),
          ],
        ),
      ),
    );
  }
}