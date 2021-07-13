import 'package:ekko/initializer.dart';
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
            onPressed: Initializer.isConnected.value
                ? controller.toogleShowOnlyFavs
                : null,
            backgroundColor: Colors.black,
            child: controller.showOnlyFavs.value
                ? const Icon(Icons.favorite, color: Colors.red)
                : const Icon(Icons.favorite),
          ),
        ),
        body: Column(
          children: [
            Obx(
              () => Visibility(
                visible: !Initializer.isConnected.value,
                child: Container(
                  height: 20,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.amber,
                  child: const Text(
                    'Falha de conexão, apenas os favoritos irão aparecer!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              child: Obx(
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
          ],
        ),
      ),
    );
  }
}
