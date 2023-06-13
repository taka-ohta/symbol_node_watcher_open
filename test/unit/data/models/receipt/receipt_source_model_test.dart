import 'package:flutter_test/flutter_test.dart';
import 'package:symbol_node_watcher/data/models/receipt/receipt_source_model.dart';

void main() {
  group('receipt_source_model', () {
    test('JSONからの変換', () {
      var model =
          ReceiptSourceModel.fromJson({"primaryId": 0, "secondaryId": 0});
      expect(model.primaryId, 0);
      expect(model.secondaryId, 0);
    });
  });
}
