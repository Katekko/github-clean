import 'package:ekko/domain/core/abstractions/base_entity.interface.dart';
import 'package:ekko/domain/core/abstractions/database.interface.dart';
import 'package:get/get.dart';

abstract class IBaseDao<T extends IBaseEntity> {
  /// Get all the entities
  List<T> getAll() {
    final dao = Get.find<IDatabase<T>>();
    return dao.selectAll();
  }

  /// Save the entity and return ID when successfully
  int save(T entity) {
    final dao = Get.find<IDatabase<T>>();
    return dao.save(entity);
  }

  /// Remove the entity and return true when successfully
  bool delete(T entity) {
    final dao = Get.find<IDatabase<T>>();
    return dao.remove(entity);
  }
}
