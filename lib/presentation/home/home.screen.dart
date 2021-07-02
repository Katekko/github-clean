import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Page')),
    );
  }
}
