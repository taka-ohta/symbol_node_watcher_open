import 'package:symbol_node_watcher/domain/entities/block/block_info.dart';

// TODO: epochをちゃんと実装する.ひとまずは固定にしておく
const EPOCH_ADJUSTMENT = 1615853185000;

class BlockInfoModel extends BlockInfo {
  BlockInfoModel({
    required BigInt height,
    required DateTime timestamp,
  }) : super(height: height, timestamp: timestamp);

  factory BlockInfoModel.fromJson(Map<String, dynamic> json) {
    return BlockInfoModel(
      height: BigInt.parse(json['block']['height']),
      timestamp: DateTime.fromMillisecondsSinceEpoch(
        EPOCH_ADJUSTMENT + BigInt.parse(json['block']['timestamp']).toInt(),
      ),
    );
  }
}
