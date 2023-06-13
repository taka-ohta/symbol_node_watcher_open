import 'dart:async';

import 'package:symbol_node_watcher/data/models/receipt/transaction_statement_model.dart';
import 'package:symbol_node_watcher/domain/entities/common/address.dart';
import 'package:symbol_node_watcher/domain/entities/common/amount.dart';
import 'package:symbol_node_watcher/domain/entities/common/host.dart';
import 'package:symbol_node_watcher/domain/entities/receipt/inflation_receipt.dart';
import 'package:symbol_node_watcher/domain/usecase/account/get_main_account_info.dart';
import 'package:symbol_node_watcher/domain/usecase/base/usecase.dart';
import 'package:symbol_node_watcher/domain/usecase/block/get_block_info.dart';
import 'package:symbol_node_watcher/domain/usecase/receipt/get_transaction_statement_list.dart';

class HarvestInfo {
  Address beneficiaryAddress;
  BigInt height;
  Amount amount;
  DateTime timestamp;
  HarvestInfo({
    required this.beneficiaryAddress,
    required this.height,
    required this.amount,
    required this.timestamp,
  });
}

class GetHarvestHistoryParam {
  Host host;
  String publicKey;
  GetHarvestHistoryParam({required this.host, required this.publicKey});
}

class GetHarvestHistory
    extends UseCase<List<HarvestInfo>, GetHarvestHistoryParam> {
  int _page = 1;
  bool _requesting = false;
  bool _last = false;
  bool get requesting => this._requesting;
  bool get last => this._last;

  @override
  Future<Stream<List<HarvestInfo>>> call(GetHarvestHistoryParam params) async {
    final controller = StreamController<List<HarvestInfo>>();
    if (!this._last) {
      try {
        this._requesting = true;
        final usecase = GetMainAccountInfo();
        final stream = await usecase.call(GetMainAccountInfoParam(
          host: params.host,
          publicKey: params.publicKey,
        ));
        stream.listen((data) async {
          final targetAddress = data.address;
          final usecase = GetTransactionStatementList();
          final stream = await usecase.call(GetTransactionStatementListParam(
            host: params.host,
            targetAddress: targetAddress.base32Address,
            page: this._page,
          ));
          stream.listen((data) async {
            if (data != null) {
              if (data.statements.length == 0) {
                this._last = true;
                controller.close();
              } else {
                List<HarvestInfo> list = [];
                var finishCount = 0;
                data.statements
                    .forEach((TransactionStatementModel statement) async {
                  final usecase = GetBlockInfo();
                  final stream = await usecase.call(
                    GetBlockInfoParam(
                      host: params.host,
                      height: statement.height,
                    ),
                  );
                  stream.listen((blockInfo) async {
                    if (blockInfo != null) {
                      final receipts = statement.filter<InflationReceipt>(
                        targetAddress,
                      );
                      receipts.forEach((receipt) {
                        list.add(HarvestInfo(
                          beneficiaryAddress: receipt.targetAddress,
                          height: statement.height,
                          amount: receipt.amount,
                          timestamp: blockInfo.timestamp,
                        ));
                      });
                      ++finishCount;
                      if (finishCount == data.statements.length) {
                        this._page++;
                        list.sort((a, b) => b.timestamp.compareTo(a.timestamp));
                        controller.add(list);
                        controller.close();
                        this._requesting = false;
                      }
                    }
                  });
                });
              }
            }
          });
        });
      } catch (_) {
        this._requesting = false;
        controller.close();
      }
    } else {
      controller.close();
    }
    return controller.stream;
  }
}
