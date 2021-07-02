import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './controllers/home.controller.dart';
import 'widgets/search_app_bar.widget.dart';
import 'widgets/user_list_item.widget.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(),
      body: Obx(
        () => ListView.separated(
          itemCount: controller.users.length,
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (_, index) => UserListItemWidget(
            controller.users[index],
          ),
        ),
      ),
    );
  }
}
