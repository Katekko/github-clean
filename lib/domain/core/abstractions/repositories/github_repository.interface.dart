import 'package:ekko/domain/github/models/user.model.dart';
import 'package:ekko/domain/github/models/user_profile.model.dart';

abstract class IGitHubRepository {
  Future<List<UserModel>> getUsers({
    required String searchText,
    required int page,
    required bool onlyFavs,
  });

  Future<UserProfileModel> getUserProfileByLogin({required String login});

  Future<void> toogleFavUser({required UserModel user});
}
