import 'package:ekko/domain/github/models/user.model.dart';
import 'package:ekko/infrastructure/dal/services/github/git_hub.service.dart';

class GitHubRepository {
  final GitHubService _gitHubService;

  GitHubRepository({required GitHubService gitHubService})
      : _gitHubService = gitHubService;

  Future<List<UserModel>> getUsers({
    required String term,
    required int page,
  }) async {
    try {
      final response = await _gitHubService.getUsers(page: page, term: term);
      final models = response.map((e) => UserModel.fromData(e)).toList();
      return models;
    } catch (err) {
      rethrow;
    }
  }
}
