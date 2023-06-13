import 'dart:async';

import 'package:symbol_node_watcher/di/dependency_injection.dart';
import 'package:symbol_node_watcher/domain/entities/account/account_info.dart';
import 'package:symbol_node_watcher/domain/entities/account/account_type.dart';
import 'package:symbol_node_watcher/domain/entities/common/host.dart';
import 'package:symbol_node_watcher/domain/repositories/symbol/account_repository.dart';
import 'package:symbol_node_watcher/domain/usecase/base/usecase.dart';

class GetMainAccountInfoParam {
  final Host host;
  final String publicKey;
  GetMainAccountInfoParam({required this.host, required this.publicKey});
}

class GetMainAccountInfo extends UseCase<AccountInfo, GetMainAccountInfoParam> {
  @override
  Future<Stream<AccountInfo>> call(GetMainAccountInfoParam params) async {
    final accountRepository = getIt<AccountRepository>(param1: params.host);
    final controller = StreamController<AccountInfo>();
    final account = await accountRepository.getAccountInfo(
      publicKey: params.publicKey,
    );
    if (account != null) {
      if (account.accountType == AccountType.Main) {
        controller.add(account);
      } else if (account.supplementalPublicKeys.linked != null) {
        final linkedAccount = await accountRepository.getAccountInfo(
          publicKey: account.supplementalPublicKeys.linked!,
        );
        if (linkedAccount != null &&
            linkedAccount.accountType == AccountType.Main) {
          controller.add(linkedAccount);
        }
      }
    }
    controller.close();
    return controller.stream;
  }
}
