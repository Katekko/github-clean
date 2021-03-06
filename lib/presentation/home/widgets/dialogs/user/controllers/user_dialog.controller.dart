import 'package:ekko/domain/core/utils/snackbar.util.dart';
import 'package:ekko/domain/github/git_hub.repository.dart';
import 'package:ekko/domain/github/models/user_profile.model.dart';
import 'package:get/get.dart';

class UserDialogController extends GetxController {
  final GitHubRepository _gitHubRepository;
  var _userLogin = '';

  final user = Rxn<UserProfileModel>();

  UserDialogController({required GitHubRepository gitHubRepository})
      : _gitHubRepository = gitHubRepository {
    final name = Get.arguments['userLogin'] as String;
    _userLogin = name;
  }

  @override
  void onReady() {
    super.onReady();
    getUserByLogin();
  }

  Future<void> getUserByLogin() async {
    try {
      final response = await _gitHubRepository.getUserProfileByLogin(
        login: _userLogin,
      );
      user.value = response;
    } catch (err) {
      Get.back();
      SnackbarUtil.showError(message: err.toString());
      rethrow;
    }
  }

  void toogleFavUser() {
    _gitHubRepository.toggleFavUser(user: user.value!);
  }
}
