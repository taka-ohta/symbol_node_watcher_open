import 'package:symbol_node_watcher/domain/entities/account/account_info.dart';

abstract class AccountRepository {
  Future<AccountInfo?> getAccountInfo({required String publicKey, int timeOut});
}
