import 'package:ekko/domain/core/utils/snackbar.util.dart';
import 'package:ekko/domain/github/git_hub.repository.dart';
import 'package:ekko/domain/github/models/user.model.dart';
import 'package:ekko/presentation/shared/loading/loading.controller.dart';

import 'package:get/get.dart';

class HomeController extends GetxController {
  final GitHubRepository _gitHubRepository;
  final _loading = Get.find<LoadingController>();
  final term = ''.obs;
  final users = <UserModel>[].obs;

  HomeController({required GitHubRepository gitHubRepository})
      : _gitHubRepository = gitHubRepository;

  @override
  Future<void> onReady() async {
    super.onReady();
    try {
      _loading.isLoading = true;
      await _gitHubRepository.getUsers(page: 1, term: term.value);
    } catch (err) {
      SnackbarUtil.showError(message: err.toString());
      rethrow;
    } finally {
      _loading.isLoading = false;
    }
  }
}
