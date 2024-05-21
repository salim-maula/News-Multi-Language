// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class WebViewWidgets extends StatefulWidget {
//   final String url;
//   const WebViewWidgets({super.key, required this.url});

//   @override
//   State<WebViewWidgets> createState() => _WebViewWidgetsState();
// }

// class _WebViewWidgetsState extends State<WebViewWidgets> {
//   late final WebViewController webVController;
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Get.back();
//           },
//           icon: const Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: Stack(
//         children: [
//           WebView(
//             initialUrl: widget.url,
//             javascriptMode: JavascriptMode.unrestricted,
//             onPageFinished: (_) {
//               _WebViewWidgetsState();
//             },
//           ),
//           if (isLoading) const Center(child: CircularProgressIndicator()),
//         ],
//       ),
//     );
//   }

//   void _injectJavaScript() async {
//     if (webVController != null) {
//       await webVController!.evaluateJavascript(
//         '''
//         function translateText() {
//             // JavaScript code to translate text
//             // You can add translation logic here
//             const elements = document.querySelectorAll('p, h1, h2, h3, h4, h5, h6, span, div'); // Select text elements
//             elements.forEach(element => {
//               const textToTranslate = element.innerText;
//               const sourceLanguage = "en"; // Source language (English)
//               const targetLanguage = "ko"; // Target language (Korean)

//               fetch(`https://translate.googleapis.com/translate_a/single?client=gtx&sl=${sourceLanguage}&tl=${targetLanguage}&dt=t&q=${textToTranslate}`)
//                   .then(response => response.json())
//                   .then(data => {
//                       const translatedText = data[0][0][0];
//                       element.innerText = translatedText;
//                   })
//                   .catch(error => console.error('Error:', error));
//             });
//         }

//         translateText(); // Translate text when the page loads
//         ''',
//       );
//     }
//   }
// }
