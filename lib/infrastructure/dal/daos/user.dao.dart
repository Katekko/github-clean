import 'package:ekko/domain/core/abstractions/daos/user_dao.interface.dart';
import 'package:ekko/domain/core/abstractions/database.interface.dart';
import 'package:ekko/infrastructure/dal/entities/user.entity.dart';
import 'package:ekko/objectbox.g.dart';
import 'package:get/get.dart';

class UserDao implements IUserDao {
  @override
  List<UserEntity> getAll() {
    final userDao = Get.find<IDatabase<UserEntity>>();
    return userDao.selectAll();
  }

  @override
  List<UserEntity> getByLogin({required String login}) {
    final userDao = Get.find<IDatabase<UserEntity>>();
    return userDao.select(
      UserEntity_.login.contains(login, caseSensitive: false),
    );
  }

  @override
  int save({required UserEntity user}) {
    final userDao = Get.find<IDatabase<UserEntity>>();
    return userDao.save(user);
  }

  @override
  bool delete({required UserEntity user}) {
    final userDao = Get.find<IDatabase<UserEntity>>();
    return userDao.remove(user);
  }
}
