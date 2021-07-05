import 'package:ekko/presentation/home/widgets/dialogs/user/controllers/user_dialog.controller.dart';
import 'package:ekko/presentation/home/widgets/dialogs/user/widgets/nickname.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import 'email.widget.dart';
import 'location.widget.dart';

class InfoWidget extends GetView<UserDialogController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .5,
        child: Obx(
          () {
            final user = controller.user.value;
            if (user != null) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  NicknameWidget(),
                  SizedBox(height: 3),
                  EmailWidget(),
                  SizedBox(height: 3),
                  LocationWidget(),
                ],
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
        ),
      ),
    );
  }
}
