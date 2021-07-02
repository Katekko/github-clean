import 'package:ekko/presentation/home/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchAppBar extends GetView<HomeController>
    implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
              visible: false,
              replacement: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Image.asset(
                  'assets/images/github.png',
                  width: 30,
                  color: Colors.white,
                ),
              ),
              child: const BackButton(),
            ),
            const Text(
              'GitHub Accounts',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
