import 'package:ekko/domain/core/abstractions/database.interface.dart';
import 'package:ekko/infrastructure/dal/entities/user.entity.dart';
import 'package:ekko/objectbox.g.dart';
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
    final userDao = Get.find<IDatabase<UserEntity>>();
    final list = userDao.select(UserEntity_.serverId.equals(data.id!));
    final dao = list.isNotEmpty ? list.first : null;

    return UserModel(
      localId: dao?.id ?? 0,
      serverId: data.id!,
      login: data.login!,
      picture: data.avatarUrl!,
      isFav: dao?.isFav.obs ?? false.obs,
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
    final userEntity = Get.find<IDatabase<UserEntity>>();
    final entity = toUserEntity;
    if (isFav.value) {
      final id = userEntity.save(entity);
      localId = id;
    } else {
      userEntity.remove(entity);
    }
  }
}
