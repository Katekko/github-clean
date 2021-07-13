import 'package:ekko/domain/core/abstractions/base_entity.interface.dart';
import 'package:ekko/infrastructure/dal/entities/user.entity.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class UserProfileEntity implements IBaseEntity {
  @override
  int id;

  final user = ToOne<UserEntity>();

  final String? bio, email, location, nickname;

  UserProfileEntity({
    required this.bio,
    required this.email,
    required this.location,
    required this.nickname,
    required this.id,
  });
}
