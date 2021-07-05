import 'package:ekko/presentation/home/widgets/dialogs/user/controllers/user_dialog.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailWidget extends GetView<UserDialogController> {
  const EmailWidget();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final user = controller.user.value;
        if (user != null && user.email != null) {
          return Text(user.email!);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
