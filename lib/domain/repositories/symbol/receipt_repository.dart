import 'package:symbol_node_watcher/data/models/receipt/transaction_statement_list_model.dart';
import 'package:symbol_node_watcher/domain/entities/common/order.dart';
import 'package:symbol_node_watcher/domain/entities/receipt/receipt_type.dart';

abstract class ReceiptRepository {
  Future<TransactionStatementListModel?> searchReceipts({
    ReceiptType? type,
    String? offset,
    Order? order,
    String? targetAddress,
    int? pageNumber,
    int? pageSize,
    int timeOut,
  });
}
