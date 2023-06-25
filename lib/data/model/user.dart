import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

import 'package:tech_test/data/model/auth.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  static const String boxName = 'user';

  const User._();

  @HiveType(typeId: 1)
  const factory User({
    @HiveField(0) required String email,
    @HiveField(1) required Authentication auth,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
