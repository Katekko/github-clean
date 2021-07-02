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
        () => ListView.builder(
          itemCount: controller.users.length,
          itemBuilder: (_, index) => UserListItemWidget(
            controller.users[index],
          ),
        ),
      ),
    );
  }
}
