import 'dart:async';

import 'package:symbol_node_watcher/di/dependency_injection.dart';
import 'package:symbol_node_watcher/domain/entities/account/account_info.dart';
import 'package:symbol_node_watcher/domain/entities/common/host.dart';
import 'package:symbol_node_watcher/domain/repositories/symbol/account_repository.dart';
import 'package:symbol_node_watcher/domain/repositories/symbol/node_repository.dart';
import 'package:symbol_node_watcher/domain/usecase/base/usecase.dart';

class GetDelegateAccounts extends UseCase<AccountInfo, Host> {
  @override
  Future<Stream<AccountInfo>> call(Host host) async {
    final nodeRepository = getIt<NodeRepository>(param1: host);
    final accountRepository = getIt<AccountRepository>(param1: host);
    final controller = StreamController<AccountInfo>();
    try {
      final unlockedAccounts = await nodeRepository.getUnlockedAccounts();
      for (final unlockedAccount in unlockedAccounts.accounts) {
        final account = await accountRepository.getAccountInfo(
          publicKey: unlockedAccount.publicKey,
        );
        if (account != null && account.supplementalPublicKeys.linked != null) {
          final linkedAccount = await accountRepository.getAccountInfo(
            publicKey: account.supplementalPublicKeys.linked!,
          );
          if (linkedAccount != null) {
            controller.add(linkedAccount);
          }
        }
      }
      controller.close();
    } catch (_) {}
    return controller.stream;
  }
}
