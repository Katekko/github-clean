import 'package:ekko/domain/core/utils/snackbar.util.dart';
import 'package:ekko/domain/github/git_hub.repository.dart';
import 'package:ekko/domain/github/models/user.model.dart';
import 'package:ekko/presentation/shared/loading/loading.controller.dart';
import 'package:get/get.dart';

class UserDialogController extends GetxController {
  final GitHubRepository _gitHubRepository;
  var _userName = '';

  final user = Rxn<UserModel>();

  UserDialogController({required GitHubRepository gitHubRepository})
      : _gitHubRepository = gitHubRepository {
    final name = Get.arguments['userName'] as String;
    _userName = name;
  }

  @override
  void onReady() {
    super.onReady();
    getUserByName();
  }

  Future<void> getUserByName() async {
    try {
      final response = await _gitHubRepository.getUserByName(name: _userName);
      user.value = response;
    } catch (err) {
      SnackbarUtil.showError(message: err.toString());
      rethrow;
    }
  }
}
