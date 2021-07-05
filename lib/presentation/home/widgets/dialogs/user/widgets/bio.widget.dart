import 'package:ekko/presentation/home/widgets/dialogs/user/controllers/user_dialog.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class BioWidget extends GetView<UserDialogController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final user = controller.user.value;
        if (user != null) {
          return Visibility(
            visible: user.bio != null,
            child: Column(
              children: [
                Text('BIO', style: Get.textTheme.headline4),
                SelectableText(
                  user.bio ?? '',
                  style: Get.textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          );
        } else {
          return SizedBox.fromSize(
            size: const Size.fromHeight(45),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(.3),
              highlightColor: Colors.white38,
              child: Container(
                decoration: const BoxDecoration(color: Colors.grey),
              ),
            ),
          );
        }
      },
    );
  }
}
