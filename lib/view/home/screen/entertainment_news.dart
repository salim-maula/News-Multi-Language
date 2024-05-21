import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kolink_news/common/widget/popups/dialog_loader.dart';
import 'package:kolink_news/common/widget/shimmer/shimmer_list.dart';
import 'package:kolink_news/view/home/controller/home_controller.dart';

class EntertainmentNews extends StatefulWidget {
  const EntertainmentNews({super.key});

  @override
  State<EntertainmentNews> createState() => _EntertainmentNewsState();
}

class _EntertainmentNewsState extends State<EntertainmentNews> {
  final controller = HomeController.instance;
  // @override
  // void initState()  {
  //   // TODO: implement initState
  //   super.initState();
  //   controller.getNews("entertainment", 3);
  //   if (controller.isSuccessfull.value = false) {
  //     TPopups.openDialogError(
  //         "Error, something went wron", "assets/animation/loading.json");
  //   }
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
              : (controller.isErrorEntertainment.value = false)
                    ? NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    if (notification is ScrollEndNotification &&
                        notification.metrics.extentAfter == 0) {
                      if (!controller.isNextPageEntertainment.value) {
                        controller.scrollNextPage("entertainment",
                            controller.nextPageEntertainment.value, 3);
                        controller.isNextPageEntertainment.value = true;
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
                      itemCount: controller.allNewsEntertainment.length + 1,
                      itemBuilder: (conte, index) {
                        // var desc = controller.newsList[index].description!;
                        // controller.translator.translate(desc, from: 'en', to: 'ko');
                        if (index < controller.allNewsEntertainment.length) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: GestureDetector(
                              onTap: () {
                                print(controller
                                    .allNewsEntertainment[index].link);
                                controller.launchURL(controller
                                    .allNewsEntertainment[index].link!);
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
                                            .allNewsEntertainment[index]
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
                                          controller.allNewsEntertainment[index]
                                              .title!,
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
                                          controller.allNewsEntertainment[index]
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
                                                        .allNewsEntertainment[
                                                            index]
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
                                              controller
                                                  .allNewsEntertainment[index]
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
                          return (controller.nextPageEntertainment.value ==
                                  "NULL")
                              ? const Center(child: Text("Dont have next page"))
                              : ShimmerList();
                        }
                      }),
                ): Center(
                        child: Text(controller.messageEntertainment.value, textAlign: TextAlign.center,),
                      ),
        );
      }),
    );
  }
}
