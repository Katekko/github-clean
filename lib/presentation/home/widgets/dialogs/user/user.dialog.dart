import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/user_dialog.controller.dart';
import 'widgets/avatar_image.widget.dart';

class UserDialog extends GetView<UserDialogController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Get.back,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.transparent,
        child: Dialog(
          child: Column(
            children: [
              Row(
                children: [
                  AvatarImageWidget(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
