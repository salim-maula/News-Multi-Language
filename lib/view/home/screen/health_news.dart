import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kolink_news/common/widget/popups/dialog_loader.dart';
import 'package:kolink_news/common/widget/shimmer/shimmer_list.dart';
import 'package:kolink_news/view/home/controller/home_controller.dart';

class HealthNews extends StatefulWidget {
  const HealthNews({super.key});

  @override
  State<HealthNews> createState() => _HealthNewsState();
}

class _HealthNewsState extends State<HealthNews> {
  final controller = HomeController.instance;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   controller.getNews("health", 7);
  //   if (controller.isSuccessfull.value = false) {
  //                       TPopups.openDialogError("Error, something went wron",
  //                           "assets/animation/loading.json");
  //                     }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: (controller.isFetching.value)
              ? ShimmerList(length: 10,)
              : 
              (controller.isErrorHealth.value = false)
                    ?
              NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    if (notification is ScrollEndNotification &&
                        notification.metrics.extentAfter == 0) {
                      if (!controller.isNextPageHealth.value) {
                        controller.scrollNextPage(
                            "health", controller.nextPageHealth.value, 7);
                             controller.isNextPageHealth.value = true;
                        if (controller.isSuccessfull.value = false) {
                          TPopups.openDialogError("Error, something went wron",
                              "assets/animation/loading.json", true);
                        }
                      }
                    }
                    return false;
                  },
                  child: ListView.separated(
                      // controller: controller.scrollController,
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 20,
                          ),
                      itemCount: controller.allNewsHealth.length + 1,
                      itemBuilder: (conte, index) {
                        // var desc = controller.newsList[index].description!;
                        // controller.translator.translate(desc, from: 'en', to: 'ko');
                        if (index < controller.allNewsHealth.length) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: GestureDetector(
                              onTap: () {
                                print(controller.allNewsHealth[index].link);
                                controller.launchURL(
                                    controller.allNewsHealth[index].link!);
                                if (controller.loadingUrl.value = true) {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                  );
                                }
                                // Get.to(() => WebViewWidgets(
                                //     url: controller.newsList[index].url!));
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 90,
                                    height: 90,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: FadeInImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(controller
                                            .allNewsHealth[index].imageUrl!),
                                        placeholder: const AssetImage(
                                            "assets/images/placeholder.gif"),
                                        imageErrorBuilder:
                                            (context, error, stackTrace) {
                                          // Return your error image widget here
                                          return Image.asset(
                                              "assets/images/no_image.jpeg");
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller
                                              .allNewsHealth[index].title!,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          controller.allNewsHealth[index]
                                              .description!,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: const TextStyle(
                                            fontSize: 11,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Container(
                                                color: Colors.blue
                                                    .withOpacity(0.5),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10,
                                                      vertical: 2),
                                                  child: Text(
                                                    controller
                                                        .allNewsHealth[index]
                                                        .pubDate!,
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: SizedBox(
                                                width: 5,
                                                height: 2,
                                                child: Container(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              controller.allNewsHealth[index]
                                                  .sourceId!,
                                              style: const TextStyle(
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return (controller.nextPageHealth.value == "NULL")
                              ? const Center(child: Text("Dont have next page"))
                              : ShimmerList();
                        }
                      }),
                ): Center(
                        child: Text(controller.messageHealth.value, textAlign: TextAlign.center,),
                      ),
        );
      }),
    );
  }
}
