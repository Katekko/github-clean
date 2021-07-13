import 'package:ekko/domain/core/abstractions/base_entity.interface.dart';
import 'package:ekko/domain/core/abstractions/database.interface.dart';
import 'package:get/get.dart' as g;
import 'package:ekko/objectbox.g.dart';

class ObjectBox<T extends IBaseEntity> implements IDatabase<T> {
  static final _store = g.Get.find<Store>();
  static Box<T> _box<T>() {
    return _store.box<T>();
  }

  @override
  int save(T dao) {
    try {
      final id = _box<T>().put(dao);
      return id;
    } catch (err) {
      rethrow;
    }
  }

  @override
  List<T> selectAll() {
    try {
      final list = _box<T>().getAll();
      return list;
    } catch (err) {
      rethrow;
    }
  }

  @override
  T? selectByLocalId(int id) {
    try {
      final dao = _box<T>().get(id);
      return dao;
    } catch (err) {
      rethrow;
    }
  }

  @override
  List<T> select(Condition<T>? condition) {
    try {
      final builder = _box<T>().query(condition);
      final query = builder.build();
      final daos = query.find();
      query.close();
      return daos;
    } catch (err) {
      rethrow;
    }
  }

  @override
  bool remove(T dao) {
    try {
      final success = _box<T>().remove(dao.id);
      return success;
    } catch (err) {
      rethrow;
    }
  }

  @override
  void clear() => _box<T>().removeAll();
}
