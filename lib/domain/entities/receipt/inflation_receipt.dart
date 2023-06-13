import 'package:symbol_node_watcher/domain/entities/common/address.dart';
import 'package:symbol_node_watcher/domain/entities/common/amount.dart';
import 'package:symbol_node_watcher/domain/entities/receipt/receipt.dart';
import 'package:symbol_node_watcher/domain/entities/receipt/receipt_type.dart';

class InflationReceipt extends Receipt {
  final Address targetAddress;
  final String mosaicId;
  final Amount amount;
  InflationReceipt({
    required int version,
    required ReceiptType type,
    required this.targetAddress,
    required this.mosaicId,
    required this.amount,
  }) : super(
          version: version,
          type: type,
        );
}
