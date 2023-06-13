import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:symbol_node_watcher/ui/presenters/node/node_presenter.dart';

import 'node_item_widget.dart';

final nodeListProvider = StateNotifierProvider<NodePresenter, List<Node>>(
  (_) => NodePresenter(),
);
final nodeProvider = ScopedProvider<Node>(null);

class NodeListWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final list = useProvider(nodeListProvider);
    useEffect(() {
      context.read(nodeListProvider.notifier).request();
    }, const ['initialize']);
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) => ProviderScope(
        overrides: [nodeProvider.overrideWithValue(list[index])],
        child: NodeItemWidget(),
      ),
    );
  }
}
