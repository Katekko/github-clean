import 'package:github/github.dart';

class UserModel {
  final String login, picture;
  const UserModel({
    required this.login,
    required this.picture,
  });

  factory UserModel.fromData(User data) {
    return UserModel(
      login: data.login!,
      picture: data.avatarUrl!,
    );
  }
}
