import 'package:ekko/domain/core/abstractions/base_entity.interface.dart';
import 'package:ekko/infrastructure/dal/entities/user.entity.dart';

import 'base_dao.interface.dart';

abstract class IUserDao<T extends IBaseEntity> extends IBaseDao<T> {
  /// Get a list of users filtering by login
  List<UserEntity> getByLogin(String login);

  /// Get a list of users filtering by login
  UserEntity? getByServerId(int serverId);
}
