import 'package:flutter_test/flutter_test.dart';
import 'package:symbol_node_watcher/data/models/receipt/inflation_receipt_model.dart';
import 'package:symbol_node_watcher/data/models/receipt/transaction_statement_model.dart';
import 'package:symbol_node_watcher/domain/entities/receipt/receipt_type.dart';

void main() {
  group('transaction_statement_model', () {
    test('JSONからの変換', () {
      var model = TransactionStatementModel.fromJson({
        "statement": {
          "height": "1",
          "source": {"primaryId": 0, "secondaryId": 0},
          "receipts": [
            {
              "version": 1,
              "type": 8515,
              "targetAddress":
                  "68258605CB5ABC592FE691190202CDFD6DDEE659A6BB30B8",
              "mosaicId": "6BED913FA20223F8",
              "amount": "0"
            }
          ]
        },
        "id": "605B15AE181AFF21F72A7DA1"
      });
      expect(model.id, '605B15AE181AFF21F72A7DA1');
      expect(model.height, BigInt.from(1));
      expect(model.source.primaryId, 0);
      expect(model.source.secondaryId, 0);
      var receipts = model.filter<InflationReceiptModel>();
      expect(receipts.length, 1);
      expect(receipts[0].version, 1);
      expect(receipts[0].type, ReceiptType.Harvest_Fee);
      expect(
        receipts[0].targetAddress.rawAddress,
        '68258605CB5ABC592FE691190202CDFD6DDEE659A6BB30B8',
      );
      expect(receipts[0].mosaicId, '6BED913FA20223F8');
      expect(receipts[0].amount.amount, BigInt.from(0));
    });
  });
}
