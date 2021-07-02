import 'package:github/github.dart';

class UserModel {
  final String name, email;
  final String? picture;
  const UserModel({
    required this.name,
    required this.email,
    required this.picture,
  });

  factory UserModel.fromData(User data) {
    return UserModel(
      name: data.login ?? '',
      email: data.email ?? '',
      picture: data.avatarUrl,
    );
  }
}
