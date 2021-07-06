import 'package:ekko/infrastructure/dal/daos/user.dao.dart';
import 'package:get/get.dart';
import 'package:github/github.dart';

class UserModel {
  final int id;
  final String login, picture;
  final RxBool isFav;
  const UserModel({
    required this.id,
    required this.login,
    required this.picture,
    required this.isFav,
  });

  factory UserModel.fromData(User data) {
    return UserModel(
      id: data.id!,
      login: data.login!,
      picture: data.avatarUrl!,
      isFav: false.obs,
    );
  }

  factory UserModel.fromDao(UserDao dao) {
    return UserModel(
      id: dao.id,
      login: dao.login,
      picture: dao.picture,
      isFav: false.obs,
    );
  }

  UserDao get toDao {
    return UserDao(id: id, isFav: isFav.value, login: login, picture: picture);
  }

  void save() {
    final dao = toDao;
    dao.save(dao);
  }
}
