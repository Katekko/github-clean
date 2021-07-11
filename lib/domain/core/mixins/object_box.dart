import 'package:ekko/domain/core/abstractions/base_dao.interface.dart';
import 'package:get/get.dart' as g;
import 'package:ekko/objectbox.g.dart';

abstract class ObjectBox<T extends IBaseDao> {
  static final _store = g.Get.find<Store>();
  static Box<T> _box<T>() {
    return _store.box<T>();
  }

  static int save<T extends IBaseDao>(T dao) {
    try {
      final id = _box<T>().put(dao);
      return id;
    } catch (err) {
      rethrow;
    }
  }

  static List<T> selectAll<T extends IBaseDao>() {
    try {
      final list = _box<T>().getAll();
      return list;
    } catch (err) {
      rethrow;
    }
  }

  static T? selectByLocalId<T extends IBaseDao>(int id) {
    try {
      final dao = _box<T>().get(id);
      return dao;
    } catch (err) {
      rethrow;
    }
  }

  static List<T> select<T extends IBaseDao>(Condition<T>? condition) {
    try {
      final builder = _box<T>().query(condition);
      final query = builder.build();
      final daos = query.find();
      return daos;
    } catch (err) {
      rethrow;
    }
  }

  static bool remove<T extends IBaseDao>(T dao) {
    try {
      final success = _box<T>().remove(dao.id);
      return success;
    } catch (err) {
      rethrow;
    }
  }

  static void clear<T extends IBaseDao>() => _box<T>().removeAll();
}
