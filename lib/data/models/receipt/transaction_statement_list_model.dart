import 'package:symbol_node_watcher/data/models/common/pagenation_model.dart';
import 'package:symbol_node_watcher/data/models/receipt/transaction_statement_model.dart';
import 'package:symbol_node_watcher/domain/entities/common/pagenation.dart';

class TransactionStatementListModel {
  final List<TransactionStatementModel> statements;
  final Pagenation pagenation;
  TransactionStatementListModel({
    required this.statements,
    required this.pagenation,
  });

  factory TransactionStatementListModel.fromJson(Map<String, dynamic> json) {
    List<TransactionStatementModel> statements = [];
    final list = json['data'] as List;
    list.forEach((element) {
      statements.add(TransactionStatementModel.fromJson(element));
    });
    return TransactionStatementListModel(
      statements: statements,
      pagenation: PagenationModel.fromJson(json['pagination']),
    );
  }
}
