import 'package:ekko/domain/core/mixins/object_box.dart';
import 'package:ekko/domain/github/models/user.model.dart';
import 'package:ekko/infrastructure/dal/daos/user.dao.dart';
import 'package:ekko/infrastructure/dal/services/github/git_hub.service.dart';
import 'package:ekko/objectbox.g.dart';

import 'models/user_profile.model.dart';

class GitHubRepository {
  final GitHubService _gitHubService;

  GitHubRepository({required GitHubService gitHubService})
      : _gitHubService = gitHubService;

  Future<List<UserModel>> getUsers({
    required String searchText,
    required int page,
    required bool onlyFavs,
  }) async {
    try {
      if (onlyFavs) {
        late List<UserDao> daos;
        if (searchText.isNotEmpty) {
          daos = ObjectBox.select(
            UserDao_.login.contains(searchText, caseSensitive: false),
          );
        } else {
          daos = ObjectBox.selectAll<UserDao>();
        }

        final models = daos.map((e) => UserModel.fromDao(e)).toList();
        return models;
      } else {
        final response = await _gitHubService.getUsers(
          page: page,
          term: searchText,
        );
        final models = response.map((e) => UserModel.fromData(e)).toList();
        return models;
      }
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
