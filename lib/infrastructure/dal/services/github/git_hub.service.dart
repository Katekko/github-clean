import 'dart:convert';

import 'package:ekko/domain/core/utils/connection.util.dart';
import 'package:get/get.dart';
import 'package:github/github.dart';

class GitHubService {
  final _gitHub = Get.find<GitHub>();

  Future<List<User>> getUsers({required String term, required int page}) async {
    try {
      await ConnectionUtil.verifyConnection();
      final users = <User>[];
      if (term.isNotEmpty) {
        await for (final user in _gitHub.search.users(term, pages: 1)) {
          users.add(user);
        }
      } else {
        final response = await _gitHub.request('get', 'users');
        final json = jsonDecode(response.body) as List<dynamic>;
        final jsonUsers = json
            .map(
              (e) => User.fromJson(e as Map<String, dynamic>),
            )
            .toList();
        users.addAll(jsonUsers);
      }

      return users;
    } catch (err) {
      rethrow;
    }
  }

  Future<User> getUserByLogin({required String login}) async {
    try {
      await ConnectionUtil.verifyConnection();
      final response = await _gitHub.users.getUser(login);
      return response;
    } catch (err) {
      rethrow;
    }
  }
}
