import 'package:tech_test/data/model/auth.dart';
import 'package:tech_test/data/model/user.dart';

abstract class LocalRepository {
  Future initHive();

  Future<void> clearHive();

  /// 로컬에 저장된 유저 정보를 가져옵니다
  User? getUser();

  /// 로컬에 저장된 유저 정보(유저 정보 & 토큰 정보) 를 업데이트합니다.
  Future<bool> updateUser(User user);

  /// 로컬에 저장된 유저 정보를 모두 지웁니다
  Future clearUser();

  /// 로컬에 저장된 auth 정보를 가져옵니다
  Authentication? getAuthInfo();

  T getValue<T>({required String key, dynamic defaultValue});

  Future setValue<T>({required String key, required T value});

  Future dispose();
}
