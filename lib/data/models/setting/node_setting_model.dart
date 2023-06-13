import 'package:symbol_node_watcher/domain/entities/setting/node_setting.dart';

class NodeSettingModel extends NodeSetting {
  NodeSettingModel({
    required String name,
    required String host,
    required bool https,
    required bool notification,
  }) : super(
          name: name,
          host: host,
          https: https,
          notification: notification,
        );
  static bool validate({required String? host}) {
    if (host == null || host == '') {
      return false;
    } else if (!RegExp(
            r'^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9])$')
        .hasMatch(host)) {
      return false;
    }
    return true;
  }
}
