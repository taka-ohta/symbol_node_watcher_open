import 'package:symbol_node_watcher/domain/entities/node/node_health.dart';

class NodeHealthModel extends NodeHealth {
  NodeHealthModel({required String apiNode, required String db})
      : super(apiNode: apiNode, db: db);

  factory NodeHealthModel.fromJson(Map<String, dynamic> json) {
    return NodeHealthModel(
        apiNode: json['status']['apiNode'], db: json['status']['db']);
  }
}
