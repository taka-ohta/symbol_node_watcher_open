import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:symbol_node_watcher/domain/entities/common/host.dart';

import 'package:symbol_node_watcher/domain/entities/node/node_info.dart';
import 'package:symbol_node_watcher/ui/pages/application_main_page.dart';
import 'package:symbol_node_watcher/ui/pages/harvest_history_page.dart';
import 'package:symbol_node_watcher/ui/presenters/node/node_info_presenter.dart';
import 'package:symbol_node_watcher/ui/presenters/node/node_presenter.dart';
import 'package:symbol_node_watcher/ui/presenters/page/sub_page_presenter.dart';
import 'package:symbol_node_watcher/ui/widgets/app_bar/sub_app_bar.dart';
import 'package:symbol_node_watcher/ui/widgets/node/node_info_widget.dart';
import 'package:symbol_node_watcher/ui/widgets/node/node_list_widget.dart';
import 'package:symbol_node_watcher/ui/widgets/node/node_status_widget.dart';

final nodeInfoProvider = StateNotifierProvider<NodeInfoPresenter, NodeInfo?>(
  (_) => NodeInfoPresenter(),
);
final nodeInfoScopedProvider = ScopedProvider<NodeInfo>(null);

class NodeDetailPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final node = ModalRoute.of(context)!.settings.arguments as Node;
    useEffect(() {
      Future.microtask(
        () => context
            .read(subPageProvider.notifier)
            .change(SubPageName.NODE_DETAIL),
      );
    }, const []);
    final presenter = context.read(nodeInfoProvider.notifier);
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
          final nodeInfo = snapshot.data as NodeInfo;
          return Center(
            child: Column(
              children: [
                ProviderScope(
                  overrides: [
                    nodeProvider.overrideWithValue(node),
                  ],
                  child: NodeStatusWidget(),
                ),
                ProviderScope(
                  overrides: [
                    nodeInfoScopedProvider.overrideWithValue(nodeInfo),
                  ],
                  child: NodeInfoWidget(),
                ),
                Card(
                  margin: EdgeInsets.fromLTRB(25, 25, 25, 0),
                  child: InkWell(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Text('委任アドレス一覧'),
                          Expanded(child: Container()),
                          Icon(Icons.arrow_right),
                        ],
                      ),
                    ),
                    onTap: () async {
                      await Navigator.of(context).pushNamed(
                        '/delegate_account_list',
                        arguments: node,
                      );
                      context
                          .read(subPageProvider.notifier)
                          .change(SubPageName.NODE_DETAIL);
                    },
                  ),
                ),
                Card(
                  margin: EdgeInsets.fromLTRB(25, 25, 25, 0),
                  child: InkWell(
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Text('ハーベスト履歴'),
                            Expanded(child: Container()),
                            Icon(Icons.arrow_right),
                          ],
                        ),
                      ),
                      onTap: () async {
                        await Navigator.of(context).pushNamed(
                          '/harvest_history',
                          arguments: HarvestHistoryPageArguments(
                            node: node,
                            publicKey: nodeInfo.publicKey,
                          ),
                        );
                        context
                            .read(subPageProvider.notifier)
                            .change(SubPageName.NODE_DETAIL);
                      }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
