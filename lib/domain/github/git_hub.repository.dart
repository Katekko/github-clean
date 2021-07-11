import 'package:ekko/domain/github/models/user.model.dart';
import 'package:ekko/infrastructure/dal/services/github/git_hub.service.dart';

import 'models/user_profile.model.dart';

class GitHubRepository {
  final GitHubService _gitHubService;

  GitHubRepository({required GitHubService gitHubService})
      : _gitHubService = gitHubService;

  Future<List<UserModel>> getUsers({
    required String searchText,
    required int page,
  }) async {
    try {
      final response = await _gitHubService.getUsers(
        page: page,
        term: searchText,
      );
      final models = response.map((e) => UserModel.fromData(e)).toList();
      return models;
    } catch (err) {
      rethrow;
    }
  }

  Future<UserProfileModel> getUserByLogin({required String login}) async {
    try {
      final response = await _gitHubService.getUserByLogin(login: login);
      final models = UserProfileModel.fromData(response);
      return models;
    } catch (err) {
      rethrow;
    }
  }

  Future<void> toogleFavUser({required UserModel user}) async {
    try {
      user.isFav.value = !user.isFav.value;
      user.save();
    } catch (err) {
      rethrow;
    }
  }
}
