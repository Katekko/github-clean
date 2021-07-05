import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/user_dialog.controller.dart';
import 'widgets/avatar_image.widget.dart';
import 'widgets/name.widget.dart';

class UserDialog extends GetView<UserDialogController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Get.back,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.black.withOpacity(.4),
        child: Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AvatarImageWidget(),
                  NameWidget(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
