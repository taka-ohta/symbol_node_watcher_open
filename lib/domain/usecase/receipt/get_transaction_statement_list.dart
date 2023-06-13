import 'dart:async';

import 'package:symbol_node_watcher/data/models/receipt/transaction_statement_list_model.dart';
import 'package:symbol_node_watcher/di/dependency_injection.dart';
import 'package:symbol_node_watcher/domain/entities/common/host.dart';
import 'package:symbol_node_watcher/domain/entities/common/order.dart';
import 'package:symbol_node_watcher/domain/entities/receipt/receipt_type.dart';
import 'package:symbol_node_watcher/domain/repositories/symbol/receipt_repository.dart';
import 'package:symbol_node_watcher/domain/usecase/base/usecase.dart';

class GetTransactionStatementListParam {
  final Host host;
  final int page;
  final String targetAddress;
  GetTransactionStatementListParam({
    required this.host,
    required this.page,
    required this.targetAddress,
  });
}

class GetTransactionStatementList extends UseCase<
    TransactionStatementListModel?, GetTransactionStatementListParam> {
  @override
  Future<Stream<TransactionStatementListModel?>> call(
    GetTransactionStatementListParam param,
  ) async {
    final repository = getIt<ReceiptRepository>(param1: param.host);
    final controller = StreamController<TransactionStatementListModel?>();
    try {
      final data = await repository.searchReceipts(
        type: ReceiptType.Harvest_Fee,
        order: Order.Desc,
        pageNumber: param.page,
        pageSize: 10,
        targetAddress: param.targetAddress,
      );
      if (data == null) {
        throw Error();
      }
      controller.add(data);
      controller.close();
    } catch (e) {
      controller.add(null);
    }
    return controller.stream;
  }
}
