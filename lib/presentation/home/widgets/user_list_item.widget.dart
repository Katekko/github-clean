import 'package:ekko/domain/github/models/user.model.dart';
import 'package:flutter/material.dart';

class UserListItemWidget extends StatelessWidget {
  final UserModel user;
  const UserListItemWidget(this.user);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user.name),
    );
  }
}
