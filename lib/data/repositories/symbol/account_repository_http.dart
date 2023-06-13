import 'dart:convert';

import 'package:http/http.dart';
import 'package:symbol_node_watcher/data/models/account/account_info_model.dart';
import 'package:symbol_node_watcher/domain/entities/account/account_info.dart';
import 'package:symbol_node_watcher/domain/entities/common/host.dart';
import 'package:symbol_node_watcher/domain/repositories/symbol/account_repository.dart';

class AccountRepositoryHttp extends AccountRepository {
  Client client = Client();
  final Host _host;

  AccountRepositoryHttp({required Host host}) : this._host = host;

  @override
  Future<AccountInfo?> getAccountInfo({
    required String publicKey,
    int timeOut = 30,
  }) async {
    try {
      final response = await client
          .get(this._host.getUri('/accounts/$publicKey'))
          .timeout(Duration(seconds: timeOut));
      if (response.statusCode == 200) {
        return AccountInfoModel.fromJson(json.decode(response.body));
      }
    } catch (_) {}
    return null;
  }
}
