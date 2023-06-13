import 'dart:async';

import 'package:symbol_node_watcher/di/dependency_injection.dart';
import 'package:symbol_node_watcher/domain/entities/common/host.dart';
import 'package:symbol_node_watcher/domain/entities/node/node_info.dart';
import 'package:symbol_node_watcher/domain/repositories/symbol/node_repository.dart';
import 'package:symbol_node_watcher/domain/usecase/base/usecase.dart';

class GetNodeInfo extends UseCase<NodeInfo?, Host> {
  @override
  Future<Stream<NodeInfo?>> call(Host host) async {
    final repository = getIt<NodeRepository>(param1: host);
    final controller = StreamController<NodeInfo?>();
    try {
      final data = await repository.getNodeInfo();
      if (data == null) {
        throw Error();
      }
      controller.add(data);
      controller.close();
    } catch (e) {
      controller.add(null);
    }
    return controller.stream;
  }
}
