// // ignore_for_file: deprecated_member_use

// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';

// void main() {
//   runApp(const MaterialApp(home: ScreenYummys()));
// }

// class ScreenYummys extends StatefulWidget {
//   const ScreenYummys({Key? key}) : super(key: key);

//   @override
//   State<ScreenYummys> createState() => _ScreenYummysState();
// }

// class _ScreenYummysState extends State<ScreenYummys>
//     with AutomaticKeepAliveClientMixin {
//   late final WebViewController _controller;

//   @override
//   bool get wantKeepAlive => true;

//   @override
//   void initState() {
//     super.initState();

//     final WebViewController controller = WebViewController();
//     controller
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(const Color(0x00000000))
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             log('WebView is loading (progress: $progress%)');
//           },
//           onPageStarted: (String url) {
//             log('Page started loading: $url');
//           },
//           onPageFinished: (String url) {
//             log('Page finished loading: $url');
//           },
//           onWebResourceError: (WebResourceError error) {
//             log('''
// Page resource error:
//   code: ${error.errorCode}
//   description: ${error.description}
//   errorType: ${error.errorType}
//   isForMainFrame: ${error.isForMainFrame}
//           ''');
//           },
//           onNavigationRequest: (NavigationRequest request) {
//             final url = request.url;

//             if (url.startsWith('intent://')) {
//               launchAndroidPaymentApp(url);
//               return NavigationDecision.prevent;
//             }

//             return NavigationDecision.navigate;
//           },
//           onUrlChange: (UrlChange change) {
//             log('URL changed to ${change.url}');
//           },
//         ),
//       )
//       ..addJavaScriptChannel(
//         'Toaster',
//         onMessageReceived: (JavaScriptMessage message) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(message.message)),
//           );
//         },
//       )
//       ..loadRequest(Uri.parse('https://eatstandardyummys.dotpe.in/store/1/delivery'));

//     _controller = controller;
//   }

//   void launchAndroidPaymentApp(String intentUrl) async {
//   if (await canLaunch(intentUrl)) {
//     await launch(intentUrl);
//   } else {
//     final fallbackUrl = extractFallbackUrl(intentUrl);
//     if (fallbackUrl != null) {
//       await launch(fallbackUrl);
//     } else {
//       const defaultFallbackUrl =
//           'https://play.google.com/store/apps/details?id=com.google.android.apps.nbu.paisa.user';
//       await launch(defaultFallbackUrl);
//     }
//   }
// }

// String convertToAndroidIntentUrl(String intentUrl) {
//   final urlParts = intentUrl.split('#');
//   final androidUrl = Uri.decodeComponent(urlParts[0].replaceFirst('intent://', 'https://'));
//   return androidUrl;
// }


//   String? extractFallbackUrl(String intentUrl) {
//     final fallbackUrlStartIndex = intentUrl.indexOf('S.browser_fallback_url=');
//     if (fallbackUrlStartIndex != -1) {
//       final fallbackUrlEndIndex = intentUrl.indexOf('&', fallbackUrlStartIndex);
//       if (fallbackUrlEndIndex != -1) {
//         final fallbackUrl = intentUrl.substring(
//             fallbackUrlStartIndex + 23, fallbackUrlEndIndex);
//         return Uri.decodeComponent(fallbackUrl);
//       }
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     final double padding = MediaQuery.of(context).size.height * 0.043;

//     return WillPopScope(
//       onWillPop: () async {
//         if (await _controller.canGoBack()) {
//           _controller.goBack();
//           return false;
//         }
//         return true;
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: PageStorage(
//           bucket: PageStorageBucket(),
//           child: Padding(
//             padding: EdgeInsets.only(top: padding),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: WebViewWidget(controller: _controller),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
