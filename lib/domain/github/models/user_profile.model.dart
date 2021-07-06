import 'package:ekko/domain/github/models/user.model.dart';
import 'package:get/get.dart';
import 'package:github/github.dart';

class UserProfileModel extends UserModel {
  final String? bio, email, location, nickname;

  UserProfileModel({
    required int id,
    required String login,
    required String picture,
    required RxBool isFav,
    required this.email,
    required this.bio,
    required this.location,
    required this.nickname,
  }) : super(id: id, picture: picture, login: login, isFav: isFav);

  factory UserProfileModel.fromData(User data) {
    return UserProfileModel(
      id: data.id!,
      login: data.login!,
      picture: data.avatarUrl!,
      location: data.location,
      nickname: data.name,
      bio: data.bio,
      email: data.email,
      isFav: false.obs,
    );
  }
}
