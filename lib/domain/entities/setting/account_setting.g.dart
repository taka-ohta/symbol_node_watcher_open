// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_setting.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountSettingAdapter extends TypeAdapter<AccountSetting> {
  @override
  final int typeId = 1;

  @override
  AccountSetting read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountSetting(
      name: fields[0] as String,
      address: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AccountSetting obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountSettingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
