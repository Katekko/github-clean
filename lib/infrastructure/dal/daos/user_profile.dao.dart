import 'package:ekko/domain/core/abstractions/daos/user_profile_dao.interface.dart';
import 'package:ekko/domain/core/abstractions/database.interface.dart';
import 'package:ekko/infrastructure/dal/entities/user_profile.entity.dart';
import 'package:ekko/objectbox.g.dart';
import 'package:get/get.dart';

class UserProfileDao extends IUserProfileDao<UserProfileEntity> {
  @override
  UserProfileEntity? getByServerId(int serverId) {
    final dao = Get.find<IDatabase<UserProfileEntity>>();
    // return dao.selectUnique(UserProfileEntity_.serverId.equals(serverId));
  }
}
