import 'package:symbol_node_watcher/data/models/common/amount_model.dart';
import 'package:symbol_node_watcher/domain/entities/mosaic/mosaic.dart';

class MosaicListModel {
  List<Mosaic> mosaics;
  MosaicListModel({required this.mosaics});

  factory MosaicListModel.fromJson(List json) {
    final List<Mosaic> list = [];
    for (final mosaic in json) {
      list.add(Mosaic(
        id: mosaic['id'],
        amount: AmountModel(amount: mosaic['amount']),
      ));
    }
    return MosaicListModel(mosaics: list);
  }
}
