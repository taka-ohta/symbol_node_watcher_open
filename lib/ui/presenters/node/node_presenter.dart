import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:symbol_node_watcher/di/dependency_injection.dart';
import 'package:symbol_node_watcher/domain/entities/common/host.dart';
import 'package:symbol_node_watcher/domain/entities/node/node_health.dart';
import 'package:symbol_node_watcher/domain/repositories/symbol/node_repository.dart';
import 'package:symbol_node_watcher/domain/usecase/node/get_node_list.dart';
import 'package:uuid/uuid.dart';

enum NodeStatus {
  OK,
  ERROR,
  REFRESHING,
}

class Node {
  final String id;
  final NodeStatus status;
  final String name;
  final String host;
  final bool https;
  final bool notification;
  final DateTime? lastUpdated;
  NodeHealth? health;

  Node({
    required this.id,
    required this.status,
    required this.name,
    required this.host,
    required this.https,
    required this.notification,
    this.lastUpdated,
    this.health,
  });
}

final _uuid = Uuid();

class NodePresenter extends StateNotifier<List<Node>> {
  NodePresenter() : super([]);

  request() async {
    final usecase = GetNodeList();
    final stream = await usecase.call(null);
    stream.listen((data) {
      List<Node> list = [];
      data.forEach((element) {
        list.add(Node(
          id: _uuid.v4(),
          status: NodeStatus.REFRESHING,
          name: element.name,
          host: element.host,
          https: element.https ?? false,
          notification: element.notification ?? false,
        ));
      });
      this.state = list;
      list.forEach((element) async {
        final repository = getIt<NodeRepository>(
          param1: Host(
            host: element.host,
            https: element.https,
          ),
        );
        final status = await repository.getNodeHealth();
        element.health = status;
        if (status == null || status.apiNode == 'down' || status.db == 'down') {
          this._changeStatus(element.id, NodeStatus.ERROR);
        } else {
          this._changeStatus(element.id, NodeStatus.OK);
        }
      });
    });
  }

  _changeStatus(String id, NodeStatus status) {
    final now = DateTime.now();
    this.state = [
      for (final node in this.state)
        if (node.id == id)
          Node(
            id: node.id,
            status: status,
            name: node.name,
            host: node.host,
            https: node.https,
            notification: node.notification,
            lastUpdated: now,
            health: node.health,
          )
        else
          node
    ];
  }
}
