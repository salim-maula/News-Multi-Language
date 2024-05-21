import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kolink_news/common/widget/loader/animation_loader.dart';

class TPopups {
  static  openDialogError(String text, String animation, bool repeat)  {
    showDialog(
      context: Get.overlayContext!,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      titlePadding: EdgeInsets.zero,
      actionsAlignment: MainAxisAlignment.center,
        content: AnimationLoaderWidget(
          repeat:repeat,
          animation: animation,
          text: text,
          showAction: true,
          actionText: "Ok",
          onActionPressed: () {
            Navigator.pop(Get.overlayContext!);
          },
        ),
      ),
    );
  }

  static stopLoading() {
    Navigator.of(Get.context!).pop();
  }
}
