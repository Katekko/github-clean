import 'package:ekko/domain/core/mixins/object_box.dart';
import 'package:ekko/domain/core/utils/snackbar.util.dart';
import 'package:ekko/infrastructure/dal/daos/user.dao.dart';
import 'package:ekko/presentation/home/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchAppBar extends GetView<HomeController>
    implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          color: controller.searchMode.value ? Colors.white54 : Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: controller.searchMode.value,
                replacement: Padding(
                  padding: const EdgeInsets.only(left: 9, right: 9),
                  child: GestureDetector(
                    onLongPress: () {
                      ObjectBox.clear<UserDao>();
                      SnackbarUtil.showSuccess(message: 'Box cleared');
                    },
                    child: Image.asset(
                      'assets/images/github.png',
                      width: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                child: BackButton(onPressed: controller.desactiveSearchMode),
              ),
              Flexible(
                child: Visibility(
                  visible: !controller.searchMode.value,
                  replacement: _SearchTextFieldWidget(),
                  child: const Text(
                    'GitHub Accounts',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              Visibility(
                visible: !controller.searchMode.value,
                replacement: IconButton(
                  onPressed: controller.clearSearchText,
                  icon: const Icon(Icons.close),
                ),
                child: IconButton(
                  onPressed: controller.activeSearchMode,
                  icon: const Icon(Icons.search),
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchTextFieldWidget extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: controller.searchText,
      controller: controller.searchTextController,
      focusNode: controller.searchTextFocus,
      decoration: const InputDecoration(isDense: true),
    );
  }
}
