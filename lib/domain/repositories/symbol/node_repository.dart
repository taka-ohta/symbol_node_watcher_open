import 'package:symbol_node_watcher/data/models/account/unlocked_account_list_model.dart';
import 'package:symbol_node_watcher/domain/entities/node/node_health.dart';
import 'package:symbol_node_watcher/domain/entities/node/node_info.dart';

abstract class NodeRepository {
  Future<NodeInfo?> getNodeInfo({int timeOut});
  Future<NodeHealth?> getNodeHealth({int timeOut});
  Future<UnlockedAccountListModel> getUnlockedAccounts({int timeOut});
}
