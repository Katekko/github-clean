import 'package:ekko/domain/core/abstractions/daos/user_dao.interface.dart';
import 'package:ekko/infrastructure/dal/entities/user.entity.dart';
import 'package:get/get.dart';
import 'package:github/github.dart';

class UserModel {
  int localId;
  final int serverId;
  final String login, picture;
  final RxBool isFav;
  UserModel({
    required this.localId,
    required this.serverId,
    required this.login,
    required this.picture,
    required this.isFav,
  });

  factory UserModel.fromData(User data) {
    final userDao = Get.find<IUserDao<UserEntity>>();
    final userEntity = userDao.getByServerId(data.id!);

    return UserModel(
      localId: userEntity?.id ?? 0,
      serverId: data.id!,
      login: data.login!,
      picture: data.avatarUrl!,
      isFav: userEntity?.isFav.obs ?? false.obs,
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      localId: entity.id,
      serverId: entity.serverId,
      login: entity.login,
      picture: entity.picture,
      isFav: entity.isFav.obs,
    );
  }

  UserEntity get toUserEntity {
    return UserEntity(
      id: localId,
      serverId: serverId,
      isFav: isFav.value,
      login: login,
      picture: picture,
    );
  }

  void save() {
    final userDao = Get.find<IUserDao<UserEntity>>();
    if (isFav.value) {
      final id = userDao.save(toUserEntity);
      localId = id;
    } else {
      userDao.delete(toUserEntity);
    }
  }
}
