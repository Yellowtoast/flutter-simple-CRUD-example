// 📦 Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

// 🌎 Project imports:

part 'auth.freezed.dart';
part 'auth.g.dart';

@freezed
class Authentication with _$Authentication {
  static const String boxName = 'auth';

  const Authentication._();

  @HiveType(typeId: 2)
  const factory Authentication({
    @HiveField(0) required String token,
    @HiveField(1) required DateTime expiredDate,
  }) = _Authentication;

  factory Authentication.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationFromJson(json);
}
