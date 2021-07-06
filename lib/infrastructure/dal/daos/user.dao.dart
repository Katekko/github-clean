import 'package:ekko/domain/core/abstractions/base.dao.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class UserDao extends BaseDao<UserDao> {
  int id;
  final String login, picture;
  final bool isFav;

  UserDao({
    required this.id,
    required this.login,
    required this.picture,
    required this.isFav,
  });
}
