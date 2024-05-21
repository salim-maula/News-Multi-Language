import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kolink_news/common/widget/popups/dialog_loader.dart';
import 'package:kolink_news/common/widget/shimmer/shimmer_list.dart';
import 'package:kolink_news/view/home/controller/home_controller.dart';

class TrendingNews extends StatefulWidget {
  const TrendingNews({super.key});

  @override
  State<TrendingNews> createState() => _TrendingNewsState();
}

class _TrendingNewsState extends State<TrendingNews> {
  final controller = Get.put(HomeController());
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   controller.getNews("top", 1);
  //   if (controller.isSuccessfull.value = false) {
  //     TPopups.openDialogError(
  //         "Error, something went wron", "assets/animation/loading.json");
  //   }
  //   super.initState();

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
          onRefresh: () => controller.getNews("top", 1),
          child: Obx(
             () {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: (controller.isFetching.value = true)
                    ? ShimmerList(
                        length: 10,
                      )
                    : (controller.isErrorTrending.value = false)
                        ? 
                        
                        NotificationListener<ScrollNotification>(
                            onNotification: (notification) {
                              if (notification is ScrollEndNotification &&
                                  notification.metrics.extentAfter == 0) {
                                if (!controller.isNextPageTrending.value) {
                                  controller.scrollNextPage(
                                      "top", controller.nextPageTrending.value, 1);
                                  controller.isNextPageTrending.value = true;
                                  if (controller.isSuccessfull.value = false) {
                                    TPopups.openDialogError(
                                        "Error, something went wron",
                                        "assets/animation/loading.json",
                                        true);
                                  }
                                }
                              }
                              return false;
                            },
                            child: ListView.separated(
                                // controller: controller.scrollController,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: 20,
                                    ),
                                itemCount: controller.allNewsTrending.length + 1,
                                itemBuilder: (conte, index) {
                                  // var desc = controller.newsList[index].description!;
                                  // controller.translator.translate(desc, from: 'en', to: 'ko');
                                  if (index < controller.allNewsTrending.length) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.symmetric(horizontal: 4),
                                      child: GestureDetector(
                                        onTap: () {
                                          print(controller
                                              .allNewsTrending[index].link);
                                          controller.launchURL(controller
                                              .allNewsTrending[index].link!);
                                          print("AAAAAAAAAAAAA");
                                          print(controller
                                              .allNewsTrending[index].link);
                                          if (controller.loadingUrl.value = true) {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
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
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: FadeInImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(controller
                                                      .allNewsTrending[index]
                                                      .imageUrl!),
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
                                                        .allNewsTrending[index]
                                                        .title!,
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    controller
                                                        .allNewsTrending[index]
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
                                                            BorderRadius.circular(
                                                                8),
                                                        child: Container(
                                                          color: Colors.blue
                                                              .withOpacity(0.5),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal: 10,
                                                                    vertical: 2),
                                                            child: Text(
                                                              controller
                                                                  .allNewsTrending[
                                                                      index]
                                                                  .pubDate!,
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize: 10,
                                                                      color: Colors
                                                                          .black),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .symmetric(
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
                                                        controller
                                                            .allNewsTrending[index]
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
                                    return (controller.nextPageBusiness.value ==
                                            "NULL")
                                        ? const Center(
                                            child: Text("Dont have next page"))
                                        : ShimmerList();
                                  }
                                }),
                          )
                        : Center(
                            child: Text(
                              controller.messageTrending.value,
                              textAlign: TextAlign.center,
                            ),
                          ),
              );
            }
          ),
        )
      
    );
  }
}
