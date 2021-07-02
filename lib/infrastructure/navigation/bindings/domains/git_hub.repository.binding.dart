import 'package:ekko/domain/github/git_hub.repository.dart';
import 'package:ekko/infrastructure/dal/services/github/git_hub.service.dart';

class GitHubRepositoryBinding {
  late GitHubRepository _gitHubRepository;
  GitHubRepository get repository => _gitHubRepository;

  GitHubRepositoryBinding() {
    final gitHubService = GitHubService();
    _gitHubRepository = GitHubRepository(gitHubService: gitHubService);
  }
}
