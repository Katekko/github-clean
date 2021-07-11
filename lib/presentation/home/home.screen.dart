import 'package:ekko/presentation/shared/loading/base.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './controllers/home.controller.dart';
import 'widgets/search_app_bar.widget.dart';
import 'widgets/user_list_item.widget.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: Scaffold(
        appBar: SearchAppBar(),
        floatingActionButton: Obx(
          () => FloatingActionButton(
            onPressed: controller.toogleShowOnlyFavs,
            backgroundColor: Colors.black,
            child: controller.showOnlyFavs.value
                ? const Icon(Icons.favorite, color: Colors.red)
                : const Icon(Icons.favorite),
          ),
        ),
        body: Obx(
          () => ListView.separated(
            itemCount: controller.users.length,
            padding: const EdgeInsets.only(top: 10, bottom: 60),
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (_, index) => UserListItemWidget(
              controller.users[index],
            ),
          ),
        ),
      ),
    );
  }
}
