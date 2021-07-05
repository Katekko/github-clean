import 'package:ekko/presentation/home/widgets/dialogs/user/controllers/user_dialog.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class NameWidget extends GetView<UserDialogController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.user.value != null) {
          return Text(controller.user.value!.login);
        } else {
          return SizedBox(
            width: MediaQuery.of(context).size.width * .5,
            height: 45,
            child: Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(.3),
              highlightColor: Colors.white38,
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(color: Colors.grey),
              ),
            ),
          );
        }
      },
    );
  }
}
