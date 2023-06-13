import 'package:flutter_test/flutter_test.dart';
import 'package:symbol_node_watcher/data/models/mosaic/mosaic_list_model.dart';

void main() {
  group('mosaic_list_model_test', () {
    test('JSONからの変換', () {
      var model = MosaicListModel.fromJson([
        {"id": "6BED913FA20223F8", "amount": "1084216792645"}
      ]);
      expect(model.mosaics.length, 1);
      expect(model.mosaics[0].id, '6BED913FA20223F8');
      expect(
        model.mosaics[0].amount.amount.toUnsigned(64),
        BigInt.from(1084216792645),
      );
    });
  });
}
