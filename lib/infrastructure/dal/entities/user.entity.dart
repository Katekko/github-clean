import 'package:ekko/domain/core/abstractions/base_entity.interface.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class UserEntity implements IBaseEntity {
  @override
  int id;

  @Unique()
  int serverId;

  final String login, picture;
  final bool isFav;

  UserEntity({
    required this.id,
    required this.serverId,
    required this.login,
    required this.picture,
    required this.isFav,
  });
}
