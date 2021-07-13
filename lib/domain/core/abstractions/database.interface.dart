import 'package:ekko/domain/core/abstractions/base_entity.interface.dart';
import 'package:ekko/objectbox.g.dart';

abstract class IDatabase<T extends IBaseEntity> {
  int save(T entity);
  List<T> selectAll();
  T? selectByLocalId(int id);
  bool remove(T entity);
  void clear();

  List<T> select(Condition<T>? condition);
}
