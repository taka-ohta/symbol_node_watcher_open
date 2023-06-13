import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:symbol_node_watcher/domain/entities/account/account_info.dart';
import 'package:symbol_node_watcher/domain/entities/common/host.dart';
import 'package:symbol_node_watcher/domain/usecase/account/get_delegate_accounts.dart';

class DelegateAccountPresenter extends StateNotifier<List<AccountInfo>> {
  DelegateAccountPresenter() : super([]);

  Future<void> request(Host host) async {
    final usecase = GetDelegateAccounts();
    final stream = await usecase.call(host);
    stream.listen((data) {
      final list = [...this.state];
      list.add(data);
      this.state = list;
    });
  }
}
