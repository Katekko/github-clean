import 'package:ekko/domain/core/abstractions/daos/user_profile_dao.interface.dart';
import 'package:ekko/domain/github/models/user.model.dart';
import 'package:ekko/infrastructure/dal/entities/user_profile.entity.dart';
import 'package:get/get.dart';
import 'package:github/github.dart';

class UserProfileModel extends UserModel {
  int localProfileId;
  final String? bio, email, location, nickname;

  UserProfileModel({
    required int serverId,
    required int localId,
    required String login,
    required String picture,
    required RxBool isFav,
    required this.localProfileId,
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
    final dao = Get.find<IUserProfileDao<UserProfileEntity>>();
    final entity = dao.getByServerId(data.id!);

    return UserProfileModel(
      serverId: data.id!,
      localProfileId: entity?.id ?? 0,
      localId: entity?.user.targetId ?? 0,
      login: data.login!,
      picture: data.avatarUrl!,
      location: data.location,
      nickname: data.name,
      bio: data.bio,
      email: data.email,
      isFav: entity?.user.target?.isFav.obs ?? false.obs,
    );
  }

  factory UserProfileModel.fromEntity(UserProfileEntity entity) {
    return UserProfileModel(
      localId: entity.user.targetId,
      localProfileId: entity.id,
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
      id: localProfileId,
      bio: bio,
      email: email,
      location: location,
      nickname: nickname,
    );
  }

  @override
  void save() {
    final dao = Get.find<IUserProfileDao<UserProfileEntity>>();
    if (isFav.value) {
      toUserProfileEntity.user.target = toUserEntity;

      final id = dao.save(toUserProfileEntity);
      localProfileId = id;

      final userProfile = dao.getByLocalId(id);
      print(userProfile?.user.target?.login);
    } else {
      dao.delete(toUserProfileEntity);
    }
  }
}
