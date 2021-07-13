import 'package:ekko/domain/core/abstractions/daos/user_profile_dao.interface.dart';
import 'package:ekko/domain/core/abstractions/database.interface.dart';
import 'package:ekko/infrastructure/dal/entities/user_profile.entity.dart';
import 'package:ekko/objectbox.g.dart';
import 'package:get/get.dart';

class UserProfileDao extends IUserProfileDao<UserProfileEntity> {
  @override
  UserProfileEntity? getByServerId(int serverId) {
    final dao = Get.find<IDatabase<UserProfileEntity>>();
    final builder = dao.getQueryBuilder();
    builder.link(
      UserProfileEntity_.user,
      UserEntity_.serverId.equals(serverId),
    );

    final query = builder.build();
    final profile = query.findFirst();
    query.close();
    return profile;
  }
}
