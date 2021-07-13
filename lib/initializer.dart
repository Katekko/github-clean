import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ekko/domain/core/abstractions/database.interface.dart';
import 'package:ekko/domain/core/mixins/object_box.dart';
import 'package:ekko/infrastructure/dal/entities/user.entity.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:github/github.dart';
import 'package:logger/logger.dart';

import 'config.dart';
import 'domain/core/constants/storage.constants.dart';

import 'objectbox.g.dart';
import 'presentation/shared/loading/loading.controller.dart';

class Initializer {
  static final isConnected = true.obs;

  static Future<void> init() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await _initStorage();
      await _initDatabase();
      await _initConnectivity();
      _initGitHub();
      _initGetConnect();
      _initGlobalLoading();
      _initScreenPreference();
    } catch (err) {
      rethrow;
    }
  }

  static Future<void> _initGetConnect() async {
    final connect = GetConnect();
    final url = ConfigEnvironments.getEnvironments()['url'];
    connect.baseUrl = url;
    connect.timeout = const Duration(seconds: 20);
    connect.httpClient.maxAuthRetries = 0;

    connect.httpClient.addRequestModifier<dynamic>(
      (request) {
        final storage = Get.find<GetStorage>();
        final token = storage.read(StorageConstants.TOKEN_AUTHORIZATION);
        if (token != null) {
          request.headers['Authorization'] = 'Bearer $token';
        }
        return request;
      },
    );

    connect.httpClient.addResponseModifier(
      (request, response) async {
        // if (response.statusCode == 401) {
        //   final authDomainBinding = AuthRepositoryBinding();
        //   await authDomainBinding.repository.logoutUser();
        //   Get.offAllNamed(Routes.LOGIN);
        //   SnackbarUtil.showWarning(
        //     message: 'Faça login novamente para continuar utilizando o sistema',
        //   );
        // }
      },
    );

    Logger().i('Conectado em: $url');
    Get.put(connect);
  }

  static void _initGlobalLoading() {
    final loading = LoadingController();
    Get.put(loading);
  }

  static Future<void> _initStorage() async {
    await GetStorage.init();
    Get.put(GetStorage());
  }

  static void _initScreenPreference() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  static void _initGitHub() {
    final env = ConfigEnvironments.getEnvironments();
    final github = GitHub(auth: Authentication.withToken(env['token-git']));
    Get.put(github);
  }

  static Future<void> _initObjectBox() async {
    final store = await openStore();
    Get.put(store);
  }

  static Future<void> _initDatabase() async {
    await _initObjectBox();
    Get.lazyPut<IDatabase<UserEntity>>(() => ObjectBox());
  }

  static Future<void> _initConnectivity() async {
    final connectivity = Connectivity();
    connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      isConnected.value = result != ConnectivityResult.none;
    });

    final result = await connectivity.checkConnectivity();
    isConnected.value = result != ConnectivityResult.none;
  }
}
