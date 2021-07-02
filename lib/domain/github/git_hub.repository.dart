import 'package:ekko/infrastructure/dal/services/github/git_hub.service.dart';

class GitHubRepository {
  final GitHubService _gitHubService;

  GitHubRepository({required GitHubService gitHubService})
      : _gitHubService = gitHubService;

  Future<void> authenticateUser() async {
    try {} catch (err) {
      rethrow;
    }
  }
}
