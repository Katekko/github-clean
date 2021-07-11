import 'package:ekko/domain/core/abstractions/base_dao.interface.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class UserDao implements IBaseDao {
  @override
  int id;

  @override
  int serverId;

  final String login, picture;
  final bool isFav;

  UserDao({
    required this.id,
    required this.serverId,
    required this.login,
    required this.picture,
    required this.isFav,
  });
}
