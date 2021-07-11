import 'package:ekko/domain/core/mixins/object_box.dart';
import 'package:ekko/domain/github/models/user.model.dart';
import 'package:ekko/objectbox.g.dart';
import 'package:get/get.dart';
import 'package:github/github.dart';

class UserProfileModel extends UserModel {
  final String? bio, email, location, nickname;

  UserProfileModel({
    required int id,
    required int localId,
    required String login,
    required String picture,
    required RxBool isFav,
    required this.email,
    required this.bio,
    required this.location,
    required this.nickname,
  }) : super(
          serverId: id,
          localId: localId,
          picture: picture,
          login: login,
          isFav: isFav,
        );

  factory UserProfileModel.fromData(User data) {
    final list = ObjectBox.select(UserDao_.serverId.equals(data.id!));
    final dao = list.isNotEmpty ? list.first : null;

    return UserProfileModel(
      id: data.id!,
      localId: dao?.id ?? 0,
      login: data.login!,
      picture: data.avatarUrl!,
      location: data.location,
      nickname: data.name,
      bio: data.bio,
      email: data.email,
      isFav: dao?.isFav.obs ?? false.obs,
    );
  }
}
