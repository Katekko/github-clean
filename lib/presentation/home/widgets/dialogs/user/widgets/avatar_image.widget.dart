import 'package:cached_network_image/cached_network_image.dart';
import 'package:ekko/presentation/home/widgets/dialogs/user/controllers/user_dialog.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class AvatarImageWidget extends GetView<UserDialogController> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Obx(
        () {
          if (controller.user.value != null) {
            return ClipOval(
              child: CachedNetworkImage(
                imageUrl: controller.user.value!.picture,
              ),
            );
          } else {
            return Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(.3),
              highlightColor: Colors.white38,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
