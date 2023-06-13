import 'dart:async';

import 'package:symbol_node_watcher/di/dependency_injection.dart';
import 'package:symbol_node_watcher/domain/entities/setting/node_setting.dart';
import 'package:symbol_node_watcher/domain/repositories/setting/setting_repository.dart';
import 'package:symbol_node_watcher/domain/usecase/base/usecase.dart';

class GetNodeList extends UseCase<List<NodeSetting>, void> {
  @override
  Future<Stream<List<NodeSetting>>> call(_) async {
    final repository = getIt<SettingRepository>();
    final controller = StreamController<List<NodeSetting>>();
    try {
      final data = repository.getNodeSettings();
      controller.add(data);
      controller.close();
    } catch (e) {
      controller.add([]);
    }
    return controller.stream;
  }
}
