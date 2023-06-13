import 'package:flutter_test/flutter_test.dart';
import 'package:symbol_node_watcher/data/models/common/amount_model.dart';
import 'package:symbol_node_watcher/data/models/receipt/inflation_receipt_model.dart';
import 'package:symbol_node_watcher/data/models/receipt/transaction_statement_list_model.dart';
import 'package:symbol_node_watcher/domain/entities/receipt/receipt_type.dart';

void main() {
  group('transaction_statement_list_model', () {
    test('JSONからの変換', () {
      var model = TransactionStatementListModel.fromJson({
        "data": [
          {
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
          },
          {
            "statement": {
              "height": "20",
              "source": {"primaryId": 0, "secondaryId": 0},
              "receipts": [
                {
                  "version": 1,
                  "type": 8515,
                  "targetAddress":
                      "68A2B1874ED406FA77EF21B63D8105919E61669FAD66A0D3",
                  "mosaicId": "6BED913FA20223F8",
                  "amount": "0"
                }
              ]
            },
            "id": "605B15B8181AFF21F72A7FD3"
          }
        ],
        "pagination": {
          "pageNumber": 1,
          "pageSize": 20,
        }
      });
      expect(model.pagenation.pageSize, 20);
      expect(model.pagenation.pageNumber, 1);
      expect(model.statements.length, 2);
      expect(model.statements[0].id, '605B15AE181AFF21F72A7DA1');
      expect(model.statements[0].height, BigInt.from(1));
      expect(model.statements[0].source.primaryId, 0);
      expect(model.statements[0].source.secondaryId, 0);
      var receipts = model.statements[0].filter<InflationReceiptModel>();
      expect(receipts.length, 1);
      expect(receipts[0].version, 1);
      expect(receipts[0].type, ReceiptType.Harvest_Fee);
      expect(
        receipts[0].targetAddress.rawAddress,
        '68258605CB5ABC592FE691190202CDFD6DDEE659A6BB30B8',
      );
      expect(receipts[0].mosaicId, '6BED913FA20223F8');
      expect(receipts[0].amount.amount, AmountModel(amount: '0').amount);
      receipts = model.statements[1].filter<InflationReceiptModel>();
      expect(receipts.length, 1);
      expect(receipts[0].version, 1);
      expect(receipts[0].type, ReceiptType.Harvest_Fee);
      expect(
        receipts[0].targetAddress.rawAddress,
        '68A2B1874ED406FA77EF21B63D8105919E61669FAD66A0D3',
      );
      expect(receipts[0].mosaicId, '6BED913FA20223F8');
      expect(receipts[0].amount.amount, AmountModel(amount: '0').amount);
    });
  });
}
