import 'package:ekko/presentation/home/widgets/dialogs/user/controllers/user_dialog.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NicknameWidget extends GetView<UserDialogController> {
  const NicknameWidget();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final user = controller.user.value;
        if (user != null && user.nickname != null) {
          return Text(user.nickname!, style: Get.textTheme.headline5);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
