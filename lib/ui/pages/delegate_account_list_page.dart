import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:symbol_node_watcher/domain/entities/account/account_info.dart';
import 'package:symbol_node_watcher/domain/entities/common/host.dart';

import 'package:symbol_node_watcher/ui/pages/application_main_page.dart';
import 'package:symbol_node_watcher/ui/presenters/account/delegate_account_presenter.dart';
import 'package:symbol_node_watcher/ui/presenters/node/node_presenter.dart';
import 'package:symbol_node_watcher/ui/presenters/page/sub_page_presenter.dart';
import 'package:symbol_node_watcher/ui/widgets/account/delegate_account_item_widget.dart';
import 'package:symbol_node_watcher/ui/widgets/app_bar/sub_app_bar.dart';

final delegateAccountProvider = ScopedProvider<AccountInfo>(null);

class DelegateAccountListPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final node = ModalRoute.of(context)!.settings.arguments as Node;
    useEffect(() {
      Future.microtask(
        () => context
            .read(subPageProvider.notifier)
            .change(SubPageName.DELEGATE_ACCOUNT_LIST),
      );
    }, const []);
    final delegateAccountListProvider =
        StateNotifierProvider<DelegateAccountPresenter, List<AccountInfo>>(
      (_) => DelegateAccountPresenter(),
    );
    final presenter = context.read(delegateAccountListProvider.notifier);
    presenter.request(Host(host: node.host, https: node.https));
    return Scaffold(
      appBar: SubAppBar(),
      body: StreamBuilder(
        initialData: null,
        stream: presenter.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final list = snapshot.data as List<AccountInfo>;
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) => ProviderScope(
              overrides: [
                delegateAccountProvider.overrideWithValue(list[index])
              ],
              child: DelegateAccountItemWidget(),
            ),
          );
        },
      ),
    );
  }
}
