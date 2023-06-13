import 'package:symbol_node_watcher/data/models/receipt/receipt_model.dart';
import 'package:symbol_node_watcher/data/models/receipt/receipt_source_model.dart';
import 'package:symbol_node_watcher/domain/entities/common/address.dart';
import 'package:symbol_node_watcher/domain/entities/receipt/inflation_receipt.dart';
import 'package:symbol_node_watcher/domain/entities/receipt/receipt.dart';
import 'package:symbol_node_watcher/domain/entities/receipt/transaction_statement.dart';

class TransactionStatementModel extends TransactionStatement {
  TransactionStatementModel({
    required String id,
    required BigInt height,
    required ReceiptSourceModel source,
    required List<Receipt> receipts,
  }) : super(
          id: id,
          height: height,
          source: source,
          receipts: receipts,
        );

  factory TransactionStatementModel.fromJson(Map<String, dynamic> json) {
    final List<Receipt> receipts = [];
    final list = json['statement']['receipts'] as List;
    list.forEach((receipt) {
      receipts.add(ReceiptModel.fromJson(receipt));
    });
    return TransactionStatementModel(
      id: json['id'],
      height: BigInt.parse(json['statement']['height']),
      source: ReceiptSourceModel.fromJson(json['statement']['source']),
      receipts: receipts,
    );
  }

  List<T> filter<T extends Receipt>([Address? targetAddress]) {
    List<T> list = [];
    this.receipts.forEach((receipt) {
      if (receipt is T) {
        if (receipt is InflationReceipt) {
          if (targetAddress == null ||
              receipt.targetAddress.rawAddress == targetAddress.rawAddress) {
            list.add(receipt);
          }
        } else {
          list.add(receipt);
        }
      }
    });
    return list;
  }
}
