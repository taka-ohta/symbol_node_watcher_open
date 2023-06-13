import 'dart:async';

import 'package:symbol_node_watcher/di/dependency_injection.dart';
import 'package:symbol_node_watcher/domain/entities/common/host.dart';
import 'package:symbol_node_watcher/domain/entities/node/node_health.dart';
import 'package:symbol_node_watcher/domain/repositories/symbol/node_repository.dart';
import 'package:symbol_node_watcher/domain/usecase/base/usecase.dart';

class GetNodeHealth extends UseCase<NodeHealth, Host> {
  @override
  Future<Stream<NodeHealth>> call(Host host) async {
    final repository = getIt<NodeRepository>(param1: host);
    final controller = StreamController<NodeHealth>();
    try {
      final data = await repository.getNodeHealth();
      if (data == null) {
        throw Error();
      }
      controller.add(data);
      controller.close();
    } catch (e) {
      controller.add(NodeHealth(apiNode: 'down', db: 'down'));
    }
    return controller.stream;
  }
}
