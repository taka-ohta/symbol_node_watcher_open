import 'dart:async';

import 'package:symbol_node_watcher/di/dependency_injection.dart';
import 'package:symbol_node_watcher/domain/entities/block/block_info.dart';
import 'package:symbol_node_watcher/domain/entities/common/host.dart';
import 'package:symbol_node_watcher/domain/repositories/symbol/block_repository.dart';
import 'package:symbol_node_watcher/domain/usecase/base/usecase.dart';

class GetBlockInfoParam {
  Host host;
  BigInt height;
  GetBlockInfoParam({required this.host, required this.height});
}

class GetBlockInfo extends UseCase<BlockInfo?, GetBlockInfoParam> {
  @override
  Future<Stream<BlockInfo?>> call(GetBlockInfoParam param) async {
    final repository = getIt<BlockRepository>(param1: param.host);
    final controller = StreamController<BlockInfo?>();
    try {
      final data = await repository.getBlockInfo(height: param.height);
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
