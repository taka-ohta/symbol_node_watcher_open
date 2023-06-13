import 'package:symbol_node_watcher/domain/entities/block/block_info.dart';

abstract class BlockRepository {
  Future<BlockInfo?> getBlockInfo({required BigInt height, int timeOut});
}
