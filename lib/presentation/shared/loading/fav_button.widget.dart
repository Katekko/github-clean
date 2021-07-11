import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final RxBool isFav;
  const FavButtonWidget({required this.onTap, required this.isFav});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IconButton(
        onPressed: onTap,
        icon: isFav.value
            ? const Icon(Icons.favorite, color: Colors.red)
            : const Icon(Icons.favorite),
      ),
    );
  }
}
