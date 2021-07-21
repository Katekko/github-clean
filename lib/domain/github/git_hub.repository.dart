import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ekko/domain/core/abstractions/daos/user_dao.interface.dart';
import 'package:ekko/domain/core/abstractions/daos/user_profile_dao.interface.dart';
import 'package:ekko/domain/core/abstractions/repositories/github_repository.interface.dart';
import 'package:ekko/domain/github/models/user.model.dart';
import 'package:ekko/infrastructure/dal/daos/user.dao.dart';
import 'package:ekko/infrastructure/dal/entities/user.entity.dart';
import 'package:ekko/infrastructure/dal/entities/user_profile.entity.dart';
import 'package:ekko/infrastructure/dal/services/github/git_hub.service.dart';
import 'package:get/get.dart';
import 'models/user_profile.model.dart';

class GitHubRepository implements IGitHubRepository {
  final GitHubService _gitHubService;
  final UserDao _userDao;

  GitHubRepository({
    required GitHubService gitHubService,
    required UserDao userDao,
  })  : _gitHubService = gitHubService,
        _userDao = userDao;

  @override
  Future<List<UserModel>> getUsers({
    required String searchText,
    required int page,
    required bool onlyFavs,
  }) async {
    try {
      if (onlyFavs) {
        late List<UserEntity> daos;
        if (searchText.isNotEmpty) {
          daos = _userDao.searchByLogin(searchText);
        } else {
          daos = _userDao.getAll();
        }

        final models = daos.map((e) => UserModel.fromEntity(e)).toList();
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

  @override
  Future<UserProfileModel> getUserProfileByLogin({
    required String login,
  }) async {
    try {
      final connectivity = Get.find<Connectivity>();
      final result = await connectivity.checkConnectivity();
      if (result != ConnectivityResult.none) {
        final response = await _gitHubService.getUserByLogin(login: login);
        final model = UserProfileModel.fromData(response);
        return model;
      } else {
        final profileDao = Get.find<IUserProfileDao<UserProfileEntity>>();
        final profileEntity = profileDao.getByLogin(login);

        late UserProfileModel model;
        if (profileEntity != null) {
          model = UserProfileModel.fromEntity(profileEntity);
        } else {
          final userDao = Get.find<IUserDao<UserEntity>>();
          final userEntity = userDao.getByLogin(login);
          model = UserProfileModel.fromUserEntity(userEntity!);
        }
        return model;
      }
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<void> toggleFavUser({required UserModel user}) async {
    try {
      /// Para ter o feedback instanteneo na tela
      user.isFav.value = !user.isFav.value;

      late UserProfileModel profile;
      if (user is UserProfileModel) {
        profile = user;
      } else {
        profile = await getUserProfileByLogin(login: user.login);
        profile.isFav.value = !profile.isFav.value;
      }

      profile.save();
    } catch (err) {
      rethrow;
    }
  }
}
