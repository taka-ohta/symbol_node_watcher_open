import 'package:flutter_test/flutter_test.dart';
import 'package:symbol_node_watcher/data/models/receipt/inflation_receipt_model.dart';
import 'package:symbol_node_watcher/domain/entities/receipt/receipt_type.dart';

void main() {
  group('inflation_receipt_model', () {
    test('JSONからの変換', () {
      var model = InflationReceiptModel.fromJson(
        {
          "version": 1,
          "type": 8515,
          "targetAddress": "689314BECD63248727B9E3A40BEA8E66AC0FD60C2826FFA8",
          "mosaicId": "6BED913FA20223F8",
          "amount": "134411538"
        },
      );
      expect(model.version, 1);
      expect(model.type, ReceiptType.Harvest_Fee);
      expect(model.targetAddress.rawAddress,
          '689314BECD63248727B9E3A40BEA8E66AC0FD60C2826FFA8');
      expect(model.mosaicId, '6BED913FA20223F8');
      expect(model.amount.amount, BigInt.from(134411538));
    });
  });
}
