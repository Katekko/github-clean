import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ekko/domain/core/exceptions/internet_failed.exception.dart';
import 'package:get/get.dart';

class ConnectionUtil {
  static Future<void> verifyConnection() async {
    final connection = Get.find<Connectivity>();
    final result = await connection.checkConnectivity();
    if (result == ConnectivityResult.none) {
      throw InternetFailedException();
    }
  }
}
