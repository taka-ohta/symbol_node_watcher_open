import 'package:symbol_node_watcher/domain/entities/receipt/receipt.dart';
import 'package:symbol_node_watcher/domain/entities/receipt/receipt_source.dart';

class TransactionStatement {
  final String id;
  final BigInt height;
  final ReceiptSource source;
  final List<Receipt> receipts;
  TransactionStatement({
    required this.id,
    required this.height,
    required this.source,
    required this.receipts,
  });
}
