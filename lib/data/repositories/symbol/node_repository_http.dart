import 'dart:convert';

import 'package:http/http.dart';
import 'package:symbol_node_watcher/data/models/account/unlocked_account_list_model.dart';
import 'package:symbol_node_watcher/data/models/node/node_health_model.dart';
import 'package:symbol_node_watcher/data/models/node/node_info_model.dart';
import 'package:symbol_node_watcher/domain/entities/common/host.dart';
import 'package:symbol_node_watcher/domain/entities/node/node_health.dart';
import 'package:symbol_node_watcher/domain/entities/node/node_info.dart';
import 'package:symbol_node_watcher/domain/repositories/symbol/node_repository.dart';

class NodeRepositoryHttp implements NodeRepository {
  Client client = Client();
  final Host _host;

  NodeRepositoryHttp({required Host host}) : this._host = host;

  @override
  Future<NodeInfo?> getNodeInfo({int timeOut = 30}) async {
    try {
      final response = await client
          .get(this._host.getUri('/node/info'))
          .timeout(Duration(seconds: timeOut));
      if (response.statusCode == 200) {
        return NodeInfoModel.fromJson(json.decode(response.body));
      }
    } catch (_) {}
    return null;
  }

  @override
  Future<NodeHealth?> getNodeHealth({int timeOut = 30}) async {
    try {
      final response = await client
          .get(this._host.getUri('/node/health'))
          .timeout(Duration(seconds: timeOut));
      if (response.statusCode == 200) {
        return NodeHealthModel.fromJson(json.decode(response.body));
      }
    } catch (_) {}
    return null;
  }

  @override
  Future<UnlockedAccountListModel> getUnlockedAccounts(
      {int timeOut = 30}) async {
    try {
      final response = await client
          .get(this._host.getUri('/node/unlockedaccount'))
          .timeout(Duration(seconds: timeOut));
      if (response.statusCode == 200) {
        return UnlockedAccountListModel.fromJson(json.decode(response.body));
      }
    } catch (_) {}
    return UnlockedAccountListModel(accounts: []);
  }
}
