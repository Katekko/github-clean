import 'package:ekko/domain/core/abstractions/repositories/github_repository.interface.dart';
import 'package:ekko/domain/core/utils/snackbar.util.dart';
import 'package:ekko/domain/github/models/user.model.dart';
import 'package:ekko/infrastructure/navigation/routes.dart';
import 'package:ekko/initializer.dart';
import 'package:ekko/presentation/shared/loading/loading.controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HomeController extends GetxController {
  final IGitHubRepository _gitHubRepository;
  final _loading = Get.find<LoadingController>();
  final users = <UserModel>[].obs;
  final searchMode = false.obs;

  final searchText = ''.obs;
  final searchTextFocus = FocusNode();
  final searchTextController = TextEditingController();

  final showOnlyFavs = false.obs;

  HomeController({required IGitHubRepository gitHubRepository})
      : _gitHubRepository = gitHubRepository;

  @override
  void onInit() {
    super.onInit();
    debounce(
      searchText,
      (_) => getUsers(),
      time: const Duration(milliseconds: 500),
    );
    ever<bool>(showOnlyFavs, (_) => getUsers());
    ever<bool>(
      Initializer.isConnected,
      (val) => toggleConnection(isConnected: val),
    );

    toggleConnection(isConnected: Initializer.isConnected.value);
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    getUsers();
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

  Future<void> getUsers() async {
    try {
      _loading.isLoading = true;
      users.assignAll(
        await _gitHubRepository.getUsers(
          page: 1,
          searchText: searchText.value,
          onlyFavs: showOnlyFavs.value,
        ),
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
    getUsers();
  }

  Future<void> toggleFavUser(UserModel user) async {
    try {
      _loading.isLoading = true;
      await _gitHubRepository.toggleFavUser(user: user);
    } catch (err) {
      rethrow;
    } finally {
      getUsers();
    }
  }

  void toogleShowOnlyFavs() {
    showOnlyFavs.value = !showOnlyFavs.value;
  }

  void toggleConnection({required bool isConnected}) {
    if (!isConnected) {
      showOnlyFavs.value = true;
      getUsers();
    }
  }
}
