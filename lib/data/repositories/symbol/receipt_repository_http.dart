import 'dart:convert';

import 'package:http/http.dart';
import 'package:symbol_node_watcher/domain/entities/common/host.dart';
import 'package:symbol_node_watcher/domain/entities/receipt/receipt_type.dart';
import 'package:symbol_node_watcher/domain/entities/common/order.dart';
import 'package:symbol_node_watcher/data/models/receipt/transaction_statement_list_model.dart';
import 'package:symbol_node_watcher/domain/repositories/symbol/receipt_repository.dart';

class ReceiptRepositoryHttp extends ReceiptRepository {
  Client client = Client();
  final Host _host;

  ReceiptRepositoryHttp({required Host host}) : this._host = host;

  @override
  Future<TransactionStatementListModel?> searchReceipts({
    ReceiptType? type,
    String? offset,
    Order? order,
    String? targetAddress,
    int? pageNumber,
    int? pageSize,
    int timeOut = 30,
  }) async {
    Map<String, dynamic> queryParameters = Map<String, String>();
    if (type != null) {
      queryParameters['type'] = type.value.toString();
    }
    if (offset != null) {
      queryParameters['offset'] = offset;
    }
    if (order != null) {
      queryParameters['order'] = order.value;
    }
    if (targetAddress != null) {
      queryParameters['targetAddress'] = targetAddress;
    }
    if (pageNumber != null) {
      queryParameters['pageNumber'] = pageNumber.toString();
    }
    if (pageSize != null) {
      queryParameters['pageSize'] = pageSize.toString();
    }
    try {
      final response = await client
          .get(this._host.getUri('/statements/transaction', queryParameters))
          .timeout(Duration(seconds: timeOut));
      if (response.statusCode == 200) {
        return TransactionStatementListModel.fromJson(
          json.decode(response.body),
        );
      }
    } catch (_) {}
    return null;
  }
}
