import 'package:ekko/domain/core/abstractions/database.abs.dart';
import 'package:get/get.dart' as g;
import 'package:ekko/objectbox.g.dart';

class ObjectBoxDao<T> implements DatabaseAbs<T> {
  static final _store = g.Get.find<Store>();
  static Box<T> _box<T>() {
    return _store.box<T>();
  }

  @override
  int save(T dao) {
    try {
      final id = _box<T>().put(dao);
      _store.close();
      return id;
    } catch (err) {
      rethrow;
    }
  }
}
