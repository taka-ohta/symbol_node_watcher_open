import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:symbol_node_watcher/domain/entities/common/host.dart';
import 'package:symbol_node_watcher/domain/usecase/harvest/get_harvest_history.dart';
import 'package:symbol_node_watcher/ui/pages/application_main_page.dart';
import 'package:symbol_node_watcher/ui/presenters/harvest/harvest_info_presenter.dart';
import 'package:symbol_node_watcher/ui/presenters/node/node_presenter.dart';
import 'package:symbol_node_watcher/ui/presenters/page/sub_page_presenter.dart';
import 'package:symbol_node_watcher/ui/widgets/app_bar/sub_app_bar.dart';
import 'package:symbol_node_watcher/ui/widgets/receipt/harvest_history_item_widget.dart';

final harvestInfoProvider = ScopedProvider<HarvestInfo>(null);

class HarvestHistoryPageArguments {
  final Node node;
  final String publicKey;
  HarvestHistoryPageArguments({required this.node, required this.publicKey});
}

class HarvestHistoryPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final inflationReceiptListProvider =
        StateNotifierProvider<HarvestInfoPresenter, List<HarvestInfo>>(
      (_) => HarvestInfoPresenter(),
    );
    final params = ModalRoute.of(context)!.settings.arguments
        as HarvestHistoryPageArguments;
    final presenter = context.read(inflationReceiptListProvider.notifier);
    useEffect(() {
      Future.microtask(
        () => context
            .read(subPageProvider.notifier)
            .change(SubPageName.HISTORY_INFLATION_RECEIPT_LIST),
      );
      presenter.request(
        Host(
          host: params.node.host,
          https: params.node.https,
        ),
        params.publicKey,
      );
    }, const []);
    return Scaffold(
      appBar: SubAppBar(),
      body: StreamBuilder(
        initialData: null,
        stream: presenter.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final list = snapshot.data as List<HarvestInfo>;
          return ListView.builder(
            itemCount: list.length + 2,
            itemBuilder: (context, index) {
              if (index == 0) {
                return ListTile(
                  title: Row(
                    children: [
                      Expanded(child: Text('日時')),
                      Expanded(child: Text('ブロック高')),
                      Expanded(child: Text('手数料')),
                    ],
                  ),
                  trailing: Icon(Icons.open_in_browser),
                );
              } else if (index == list.length + 1) {
                if (!presenter.last) {
                  if (!presenter.requesting) {
                    return Container(
                      child: TextButton(
                        child: Text('続きを読み込む'),
                        onPressed: () {
                          presenter.request(
                            Host(
                              host: params.node.host,
                              https: params.node.https,
                            ),
                            params.publicKey,
                          );
                        },
                      ),
                    );
                  }
                } else {
                  return Container();
                }
              }
              --index;
              return ProviderScope(
                overrides: [harvestInfoProvider.overrideWithValue(list[index])],
                child: HarvestHistoryItemWidget(),
              );
            },
          );
        },
      ),
    );
  }
}
