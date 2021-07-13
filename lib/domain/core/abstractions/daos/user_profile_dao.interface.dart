import 'package:ekko/domain/core/abstractions/base_entity.interface.dart';
import 'package:ekko/infrastructure/dal/entities/user_profile.entity.dart';

import '../base_dao.interface.dart';

abstract class IUserProfileDao<T extends IBaseEntity> extends IBaseDao<T> {
  /// Get the profile filtering by login
  UserProfileEntity? getByLogin(String login);

  /// Get user filtering by login
  UserProfileEntity? getByServerId(int serverId);
}
