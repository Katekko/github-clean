import 'package:cached_network_image/cached_network_image.dart';
import 'package:ekko/domain/github/models/user.model.dart';
import 'package:ekko/presentation/home/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserListItemWidget extends GetView<HomeController> {
  final UserModel user;
  const UserListItemWidget(this.user);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => controller.openProfile(user),
      leading: CachedNetworkImage(
        imageUrl: user.picture,
        progressIndicatorBuilder: (_, __, download) {
          return CircularProgressIndicator(value: download.progress);
        },
        errorWidget: (_, __, ___) => const Icon(Icons.error),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.favorite),
      ),
      title: Text(user.name),
    );
  }
}
