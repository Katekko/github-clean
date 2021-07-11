import 'package:ekko/domain/core/utils/snackbar.util.dart';
import 'package:ekko/domain/github/git_hub.repository.dart';
import 'package:ekko/domain/github/models/user.model.dart';
import 'package:ekko/infrastructure/navigation/routes.dart';
import 'package:ekko/presentation/shared/loading/loading.controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HomeController extends GetxController {
  final GitHubRepository _gitHubRepository;
  final _loading = Get.find<LoadingController>();
  final users = <UserModel>[].obs;
  final searchMode = false.obs;

  final searchText = ''.obs;
  final searchTextFocus = FocusNode();
  final searchTextController = TextEditingController();

  HomeController({required GitHubRepository gitHubRepository})
      : _gitHubRepository = gitHubRepository;

  @override
  void onInit() {
    super.onInit();
    debounce(searchText, searchUsers, time: const Duration(milliseconds: 500));
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    searchUsers(searchTextController.text);
  }

  void activeSearchMode() {
    searchMode.value = true;
    searchTextFocus.requestFocus();
  }

  void desactiveSearchMode() {
    searchMode.value = false;
    Get.focusScope?.unfocus();
  }

  void clearSearchText() {
    searchText.value = '';
    searchTextController.clear();
  }

  Future<void> searchUsers(String searchText) async {
    try {
      _loading.isLoading = true;
      users.assignAll(
        await _gitHubRepository.getUsers(page: 1, searchText: searchText),
      );
    } catch (err) {
      SnackbarUtil.showError(message: err.toString());
      rethrow;
    } finally {
      _loading.isLoading = false;
    }
  }

  Future<void> openProfile(UserModel user) async {
    Get.focusScope?.unfocus();
    await Get.toNamed(Routes.USER_DIALOG, arguments: {'userLogin': user.login});
    searchUsers(searchTextController.text);
  }

  void toogleUser(UserModel user) {
    _gitHubRepository.toogleFavUser(user: user);
  }
}
