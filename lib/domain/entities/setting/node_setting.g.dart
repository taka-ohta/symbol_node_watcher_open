// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_setting.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NodeSettingAdapter extends TypeAdapter<NodeSetting> {
  @override
  final int typeId = 0;

  @override
  NodeSetting read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NodeSetting(
      name: fields[0] as String,
      host: fields[1] as String,
      https: fields[2] as bool?,
      notification: fields[3] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, NodeSetting obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.host)
      ..writeByte(2)
      ..write(obj.https)
      ..writeByte(3)
      ..write(obj.notification);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NodeSettingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
