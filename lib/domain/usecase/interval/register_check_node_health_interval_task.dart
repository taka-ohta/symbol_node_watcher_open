import 'dart:async';

import 'package:symbol_node_watcher/di/dependency_injection.dart';
import 'package:symbol_node_watcher/domain/entities/common/host.dart';
import 'package:symbol_node_watcher/domain/entities/setting/node_setting.dart';
import 'package:symbol_node_watcher/domain/repositories/interval_task/intarval_task_repository.dart';
import 'package:symbol_node_watcher/domain/repositories/setting/setting_repository.dart';
import 'package:symbol_node_watcher/domain/repositories/symbol/node_repository.dart';
import 'package:symbol_node_watcher/domain/usecase/base/usecase.dart';
import 'package:symbol_node_watcher/domain/usecase/notification/notify_node_error_notification.dart';

class RegisterCheckNodeHealthIntervalTask extends UseCase<bool, void> {
  static const ID = 'NodeHealth';

  @override
  Future<Stream<bool>> call(void params) async {
    final repository = getIt<IntervalTaskRepository>();
    final controller = StreamController<bool>();

    repository.registerCallback(
      id: RegisterCheckNodeHealthIntervalTask.ID,
      callback: this._task,
    );

    controller.add(true);
    controller.close();
    return controller.stream;
  }

  _task() async {
    final settingRepository = getIt<SettingRepository>();
    final nodes = settingRepository.getNodeSettings();
    var error = false;
    await Future.forEach(nodes, (NodeSetting node) async {
      final nodeRepository = getIt<NodeRepository>(
        param1: Host(
          host: node.host,
          https: node.https ?? false,
        ),
      );
      final health = await nodeRepository.getNodeHealth(timeOut: 10);
      if (health == null || health.apiNode == 'down' || health.db == 'down') {
        error = true;
      }
    });
    if (error) {
      final notify = NotifyNodeErrorNotification();
      notify.call(null);
    }
  }
}
