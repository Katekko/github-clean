import 'package:ekko/domain/core/abstractions/database.interface.dart';
import 'package:ekko/domain/github/models/user.model.dart';
import 'package:ekko/infrastructure/dal/entities/user.entity.dart';
import 'package:ekko/infrastructure/dal/entities/user_profile.entity.dart';
import 'package:ekko/objectbox.g.dart';
import 'package:get/get.dart';
import 'package:github/github.dart';

class UserProfileModel extends UserModel {
  final String? bio, email, location, nickname;

  UserProfileModel({
    required int serverId,
    required int localId,
    required String login,
    required String picture,
    required RxBool isFav,
    required this.email,
    required this.bio,
    required this.location,
    required this.nickname,
  }) : super(
          serverId: serverId,
          localId: localId,
          picture: picture,
          login: login,
          isFav: isFav,
        );

  factory UserProfileModel.fromData(User data) {
    final userDao = Get.find<IDatabase<UserEntity>>();
    final list = userDao.select(UserEntity_.serverId.equals(data.id!));
    final dao = list.isNotEmpty ? list.first : null;

    return UserProfileModel(
      serverId: data.id!,
      localId: dao?.id ?? 0,
      login: data.login!,
      picture: data.avatarUrl!,
      location: data.location,
      nickname: data.name,
      bio: data.bio,
      email: data.email,
      isFav: dao?.isFav.obs ?? false.obs,
    );
  }

  factory UserProfileModel.fromEntity(UserProfileEntity entity) {
    return UserProfileModel(
      localId: entity.id,
      bio: entity.bio,
      email: entity.email,
      location: entity.location,
      nickname: entity.nickname,
      serverId: entity.user.target?.serverId ?? 0,
      isFav: entity.user.target?.isFav.obs ?? false.obs,
      login: entity.user.target?.login ?? '',
      picture: entity.user.target?.picture ?? '',
    );
  }

  UserProfileEntity get toUserProfileEntity {
    return UserProfileEntity(
      id: localId,
      bio: bio,
      email: email,
      location: location,
      nickname: nickname,
    );
  }

  @override
  void save() {
    final userEntity = Get.find<IDatabase<UserProfileEntity>>();
    final entity = toUserProfileEntity;
    if (isFav.value) {
      entity.user.target = toUserEntity;
      final id = userEntity.save(entity);
      localId = id;
    } else {
      userEntity.remove(entity);
    }

    super.save();
  }
}
