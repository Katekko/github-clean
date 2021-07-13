import 'package:ekko/domain/core/abstractions/daos/user_dao.interface.dart';
import 'package:ekko/domain/core/abstractions/database.interface.dart';
import 'package:ekko/infrastructure/dal/entities/user.entity.dart';
import 'package:ekko/objectbox.g.dart';
import 'package:get/get.dart';

class UserDao extends IUserDao<UserEntity> {
  @override
  List<UserEntity> getByLogin(String login) {
    final userDao = Get.find<IDatabase<UserEntity>>();
    return userDao.select(
      UserEntity_.login.contains(login, caseSensitive: false),
    );
  }

  @override
  UserEntity? getByServerId(int serverId) {
    final userDao = Get.find<IDatabase<UserEntity>>();
    return userDao.selectUnique(UserEntity_.serverId.equals(serverId));
  }
}
