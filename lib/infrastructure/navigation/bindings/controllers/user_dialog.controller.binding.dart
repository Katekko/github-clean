import 'package:ekko/infrastructure/navigation/bindings/domains/git_hub.repository.binding.dart';
import 'package:ekko/presentation/home/widgets/dialogs/user/controllers/user_dialog.controller.dart';
import 'package:get/get.dart';

class UserDialogControllerBinding extends Bindings {
  @override
  void dependencies() {
    final gitHubRepositoryBinding = GitHubRepositoryBinding();

    Get.lazyPut<UserDialogController>(
      () => UserDialogController(
        gitHubRepository: gitHubRepositoryBinding.repository,
      ),
    );
  }
}
