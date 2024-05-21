// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kolink_news/view/home/controller/home_controller.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(HomeController());
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             'Kolink News',
//             style:
//                 TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[700]),
//           ),
//           surfaceTintColor: Colors.transparent,
//           backgroundColor: Colors.white,
//           iconTheme: const IconThemeData(color: Colors.black),
//           elevation: 0,
//           actions: <Widget>[
//             Container(
//               margin: const EdgeInsets.only(right: 0),
//               child: IconButton(
//                   onPressed: () {},
//                   icon: Image.asset('assets/images/icon_user.png')),
//             )
//           ],
//         ),
//         backgroundColor: Colors.white,
//         // drawer: DrawerMenu(),
//         body: Obx(() {
//           return Padding(
//             padding:
//                 const EdgeInsets.only(top: 16, bottom: 16, right: 8, left: 8),
//             child: (controller.isFetching.value)
//                 ? const Center(child: CircularProgressIndicator())
//                 : NotificationListener<ScrollNotification>(
//                     onNotification: (notification) {
//                       if (notification is ScrollEndNotification &&
//                           notification.metrics.extentAfter == 0) {
//                         controller.scrollNextPage();
//                       }
//                       return false;
//                     },
//                     child: ListView.separated(
//                         // controller: controller.scrollController,
//                         separatorBuilder: (context, index) => const SizedBox(
//                               height: 20,
//                             ),
//                         itemCount: controller.allNews.length + 1,
//                         itemBuilder: (conte, index) {
//                           // var desc = controller.newsList[index].description!;
//                           // controller.translator.translate(desc, from: 'en', to: 'ko');
//                           if (index < controller.allNews.length) {
//                             return GestureDetector(
//                               onTap: () {
//                                 print(controller.allNews[index].link);
//                                 if (controller.storage.read("CODELANGUAGE") ==
//                                     "id") {
//                                   controller.launchURL(
//                                       controller.allNews[index].link!);
//                                 } else {
//                                   controller.launchURL(
//                                       "https://translate.google.com/translate?hl=en&sl=id&tl=${controller.storage.read("CODELANGUAGE")}&u="+controller.allNews[index].link!);
//                                 }

//                                 // Get.to(() => WebViewWidgets(
//                                 //     url: controller.newsList[index].url!));
//                               },
//                               child: Row(
//                                 children: [
//                                   SizedBox(
//                                     width: 70,
//                                     height: 70,
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(8),
//                                       child: FadeInImage(
//                                         fit: BoxFit.cover,
//                                         image: NetworkImage(controller
//                                             .allNews[index].imageUrl!),
//                                         placeholder: const AssetImage(
//                                             "assets/images/placeholder.gif"),
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     width: 10,
//                                   ),
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           controller.allNews[index].title!,
//                                           overflow: TextOverflow.ellipsis,
//                                           maxLines: 2,
//                                           style: const TextStyle(
//                                               fontSize: 13,
//                                               fontWeight: FontWeight.w500),
//                                         ),
//                                         const SizedBox(
//                                           height: 4,
//                                         ),
//                                         Text(
//                                           controller
//                                               .allNews[index].description!,
//                                           overflow: TextOverflow.ellipsis,
//                                           maxLines: 2,
//                                           style: const TextStyle(
//                                             fontSize: 11,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           } else {
//                             return const Center(
//                               child: CircularProgressIndicator(),
//                             );
//                           }
//                         }),
//                   ),
//           );
//         }),
//       ),
//     );
//   }
// }
