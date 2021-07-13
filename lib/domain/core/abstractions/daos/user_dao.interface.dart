import 'package:ekko/infrastructure/dal/entities/user.entity.dart';

abstract class IUserDao {
  /// Get all the users
  List<UserEntity> getAll();

  /// Get a list of userEntities filtering by login
  List<UserEntity> getByLogin({required String login});

  /// Save the user and return ID when successfully
  int save({required UserEntity user});

  /// Remove the user and return true when successfully
  bool delete({required UserEntity user});
}
