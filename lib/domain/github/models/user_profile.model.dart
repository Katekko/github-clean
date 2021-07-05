import 'package:ekko/domain/github/models/user.model.dart';
import 'package:github/github.dart';

class UserProfileModel extends UserModel {
  final String nickname, location, email;
  final String? bio;

  UserProfileModel({
    required String login,
    required String picture,
    required this.email,
    required this.bio,
    required this.location,
    required this.nickname,
  }) : super(picture: picture, login: login);

  factory UserProfileModel.fromData(User data) {
    return UserProfileModel(
      login: data.login!,
      email: data.email!,
      picture: data.avatarUrl!,
      location: data.location!,
      nickname: data.name!,
      bio: data.bio,
    );
  }
}
