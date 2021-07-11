import 'package:cached_network_image/cached_network_image.dart';
import 'package:ekko/presentation/home/widgets/dialogs/user/controllers/user_dialog.controller.dart';
import 'package:ekko/presentation/shared/loading/fav_button.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class AvatarImageWidget extends GetView<UserDialogController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: InkWell(
            onDoubleTap: controller.toogleFavUser,
            borderRadius: BorderRadius.circular(10000),
            child: SizedBox(
              width: 100,
              height: 100,
              child: Obx(
                () {
                  if (controller.user.value != null) {
                    return CachedNetworkImage(
                      imageUrl: controller.user.value!.picture,
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
            ),
          ),
        ),
        Obx(
          () => Visibility(
            visible: controller.user.value != null,
            child: FavButtonWidget(
              onTap: controller.toogleFavUser,
              isFav: controller.user.value?.isFav ?? false.obs,
            ),
          ),
        ),
      ],
    );
  }
}
