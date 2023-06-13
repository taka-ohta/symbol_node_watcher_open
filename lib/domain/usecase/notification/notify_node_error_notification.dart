import 'dart:async';

import 'package:symbol_node_watcher/di/dependency_injection.dart';
import 'package:symbol_node_watcher/domain/repositories/notification/notification_repository.dart';
import 'package:symbol_node_watcher/domain/usecase/base/usecase.dart';
import 'package:symbol_node_watcher/domain/usecase/notification/register_node_error_notification.dart';

class NotifyNodeErrorNotification extends UseCase<bool, void> {
  @override
  Future<Stream<bool>> call(void param) async {
    final repository = getIt<NotificationRepository>();
    final controller = StreamController<bool>();
    repository.notify(
      id: RegisterNodeErrorNotification.ID,
      title: 'ノード異常発生',
      body: 'ノードで異常が発生しました。',
    );
    controller.add(true);
    controller.close();
    return controller.stream;
  }
}
