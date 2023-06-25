import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tech_test/data/model/auth.dart';
import 'package:tech_test/data/model/user.dart';
import 'package:tech_test/data/repository/local_repository.dart';

class LocalRepositoryImpl extends GetxService implements LocalRepository {
  late Box _box;

  @override
  User? getUser() => _box.get(User.boxName);

  @override
  Authentication? getAuthInfo() {
    final User? user = _box.get(User.boxName);
    return user?.auth;
  }

  @override
  Future<bool> updateUser(User user) async {
    return await _box
        .put(User.boxName, user)
        .then((value) => true)
        .onError((error, stackTrace) => false);
  }

  @override
  Future clearUser() async {
    await _box.delete(User.boxName);
  }

  @override
  Future initHive() async {
    await Hive.initFlutter();
    _initAdaptor();
    await _openBox();
  }

  Future _openBox() async {
    _box = await Hive.openBox('dozn');
  }

  void _initAdaptor() {
    Hive
      ..registerAdapter(UserAdapter()) // 1
      ..registerAdapter(AuthenticationAdapter()); // 2
  }

  @override
  T getValue<T>({required String key, dynamic defaultValue}) =>
      _box.get(key, defaultValue: defaultValue) as T;

  @override
  Future setValue<T>({required String key, required T value}) =>
      _box.put(key, value);

  @override
  Future<void> clearHive() async => await _clearBox();

  Future<void> _clearBox() => Future.wait([
        _box.clear(),
      ]);

  Future<void> _closeBox() => Future.wait([
        _box.close(),
      ]);

  @override
  Future dispose() async {
    await _closeBox();
  }
}
