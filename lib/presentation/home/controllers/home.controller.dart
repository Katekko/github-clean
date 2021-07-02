import 'package:ekko/domain/core/utils/snackbar.util.dart';
import 'package:ekko/domain/github/git_hub.repository.dart';
import 'package:ekko/presentation/shared/loading/loading.controller.dart';

import 'package:get/get.dart';

class HomeController extends GetxController {
  final GitHubRepository _gitHubRepository;
  final _loadingController = Get.find<LoadingController>();

  HomeController({required GitHubRepository gitHubRepository})
      : _gitHubRepository = gitHubRepository;

  @override
  Future<void> onReady() async {
    super.onReady();
    try {} catch (err) {
      SnackbarUtil.showError(message: err.toString());
    } finally {
      _loadingController.isLoading = false;
    }
  }
}
