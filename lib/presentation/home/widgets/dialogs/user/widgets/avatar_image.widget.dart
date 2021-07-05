import 'package:cached_network_image/cached_network_image.dart';
import 'package:ekko/presentation/home/widgets/dialogs/user/controllers/user_dialog.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class AvatarImageWidget extends GetView<UserDialogController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.user.value != null) {
          return CircleAvatar(
            child: CachedNetworkImage(
              imageUrl: controller.user.value!.picture,
            ),
          );
        } else {
          return Shimmer.fromColors(
            baseColor: Colors.red,
            highlightColor: Colors.yellow,
            child: Container(
              decoration: const BoxDecoration(shape: BoxShape.circle),
            ),
          );
        }
      },
    );
  }
}
