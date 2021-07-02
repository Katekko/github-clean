import 'package:ekko/infrastructure/navigation/bindings/domains/git_hub.repository.binding.dart';
import 'package:ekko/presentation/home/controllers/home.controller.dart';
import 'package:get/get.dart';

class HomeControllerBinding extends Bindings {
  @override
  void dependencies() {
    final gitHubRepositoryBinding = GitHubRepositoryBinding();

    Get.lazyPut<HomeController>(
      () => HomeController(
        gitHubRepository: gitHubRepositoryBinding.repository,
      ),
    );
  }
}
