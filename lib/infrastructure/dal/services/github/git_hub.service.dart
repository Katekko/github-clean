import 'package:get/get.dart';
import 'package:github/github.dart';

class GitHubService {
  final _gitHub = Get.find<GitHub>();

  Future<List<User>> getUsers({required String term, required int page}) async {
    try {
      final users = <User>[];
      await for (final user in _gitHub.search.users('kat', pages: 1)) {
        users.add(user);
      }

      return users;
    } catch (err) {
      rethrow;
    }
  }
}
