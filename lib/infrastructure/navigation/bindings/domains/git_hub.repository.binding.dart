import 'package:ekko/domain/github/git_hub.repository.dart';
import 'package:ekko/infrastructure/dal/daos/user.dao.dart';
import 'package:ekko/infrastructure/dal/services/github/git_hub.service.dart';

class GitHubRepositoryBinding {
  late GitHubRepository _gitHubRepository;
  GitHubRepository get repository => _gitHubRepository;

  GitHubRepositoryBinding() {
    final gitHubService = GitHubService();
    final userDao = UserDao();
    _gitHubRepository = GitHubRepository(
      gitHubService: gitHubService,
      userDao: userDao,
    );
  }
}
