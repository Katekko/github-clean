import 'package:get/get.dart';

import '../../presentation/screens.dart';
import 'bindings/controllers/controllers_bindings.dart';
import 'routes.dart';

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomeScreen(),
      binding: HomeControllerBinding(),
    ),
    GetPage(
      name: Routes.USER_DIALOG,
      page: () => UserDialog(),
      binding: UserDialogControllerBinding(),
      opaque: false,
      transition: Transition.fadeIn,
    ),
  ];
}
