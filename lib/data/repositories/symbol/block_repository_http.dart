import 'dart:convert';

import 'package:http/http.dart';
import 'package:symbol_node_watcher/data/models/block/block_info_model.dart';
import 'package:symbol_node_watcher/domain/entities/block/block_info.dart';
import 'package:symbol_node_watcher/domain/entities/common/host.dart';
import 'package:symbol_node_watcher/domain/repositories/symbol/block_repository.dart';

class BlockRepositoryHttp extends BlockRepository {
  Client client = Client();
  final Host _host;

  BlockRepositoryHttp({required Host host}) : this._host = host;

  @override
  Future<BlockInfo?> getBlockInfo({
    required BigInt height,
    int timeOut = 30,
  }) async {
    try {
      final response = await client
          .get(this._host.getUri('/blocks/' + height.toString()))
          .timeout(Duration(seconds: timeOut));
      if (response.statusCode == 200) {
        return BlockInfoModel.fromJson(json.decode(response.body));
      }
    } catch (_) {}
    return null;
  }
}
