import 'package:ekko/domain/core/mixins/object_box.dart';
import 'package:ekko/infrastructure/dal/daos/user.dao.dart';
import 'package:ekko/objectbox.g.dart';
import 'package:get/get.dart';
import 'package:github/github.dart';

class UserModel {
  int localId;
  final int serverId;
  final String login, picture;
  final RxBool isFav;
  UserModel({
    required this.localId,
    required this.serverId,
    required this.login,
    required this.picture,
    required this.isFav,
  });

  factory UserModel.fromData(User data) {
    final list = ObjectBox.select(UserDao_.serverId.equals(data.id!));
    final dao = list.isNotEmpty ? list.first : null;

    return UserModel(
      localId: dao?.id ?? 0,
      serverId: data.id!,
      login: data.login!,
      picture: data.avatarUrl!,
      isFav: dao?.isFav.obs ?? false.obs,
    );
  }

  factory UserModel.fromDao(UserDao dao) {
    return UserModel(
      localId: dao.id,
      serverId: dao.serverId,
      login: dao.login,
      picture: dao.picture,
      isFav: dao.isFav.obs,
    );
  }

  UserDao get toDao {
    return UserDao(
      id: localId,
      serverId: serverId,
      isFav: isFav.value,
      login: login,
      picture: picture,
    );
  }

  void save() {
    final dao = toDao;
    if (isFav.value) {
      final id = ObjectBox.save(dao);
      localId = id;
    } else {
      ObjectBox.remove(dao);
    }
  }
}
