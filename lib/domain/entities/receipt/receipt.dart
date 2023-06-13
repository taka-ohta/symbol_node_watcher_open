import 'package:symbol_node_watcher/domain/entities/receipt/receipt_type.dart';

class Receipt {
  final int version;
  final ReceiptType type;
  Receipt({required this.version, required this.type});
}
