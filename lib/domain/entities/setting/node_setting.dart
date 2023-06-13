import 'package:hive/hive.dart';

part 'node_setting.g.dart';

@HiveType(typeId: 0)
class NodeSetting extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String host;
  @HiveField(2)
  bool? https;
  @HiveField(3)
  bool? notification;
  NodeSetting({
    required this.name,
    required this.host,
    required this.https,
    required this.notification,
  });
}
