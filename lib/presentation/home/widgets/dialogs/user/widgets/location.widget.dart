import 'package:ekko/presentation/home/widgets/dialogs/user/controllers/user_dialog.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationWidget extends GetView<UserDialogController> {
  const LocationWidget();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final user = controller.user.value;
        if (user != null && user.location != null) {
          return Text(user.location!);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
