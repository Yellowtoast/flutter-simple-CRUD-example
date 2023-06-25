// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthenticationAdapter extends TypeAdapter<_$_Authentication> {
  @override
  final int typeId = 2;

  @override
  _$_Authentication read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_Authentication(
      token: fields[0] as String,
      expiredDate: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, _$_Authentication obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.token)
      ..writeByte(1)
      ..write(obj.expiredDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthenticationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Authentication _$$_AuthenticationFromJson(Map<String, dynamic> json) =>
    _$_Authentication(
      token: json['token'] as String,
      expiredDate: DateTime.parse(json['expiredDate'] as String),
    );

Map<String, dynamic> _$$_AuthenticationToJson(_$_Authentication instance) =>
    <String, dynamic>{
      'token': instance.token,
      'expiredDate': instance.expiredDate.toIso8601String(),
    };
