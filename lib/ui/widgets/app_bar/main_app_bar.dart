import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:symbol_node_watcher/ui/pages/application_main_page.dart';
import 'package:symbol_node_watcher/ui/presenters/page/main_page_presenter.dart';
import 'package:symbol_node_watcher/ui/widgets/node/node_list_widget.dart';

class MainAppBar extends HookWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final page = useProvider(mainPageProvider);
    return AppBar(
      centerTitle: false,
      title: Text(this._getTitle(page)),
      leading: Container(),
      actions: [
        IconButton(
          icon: Icon(Icons.refresh),
          color: Colors.white,
          onPressed: () => context.read(nodeListProvider.notifier).request(),
        ),
        // IconButton(
        //   icon: Icon(Icons.notifications),
        //   color: Colors.white,
        //   onPressed: () => Navigator.of(context).pushNamed('/notification'),
        // ),
        // IconButton(
        //   icon: Icon(Icons.settings),
        //   color: Colors.white,
        //   onPressed: () => Navigator.of(context).pushNamed('/setting'),
        // ),
      ],
    );
  }

  String _getTitle(MainPageName page) {
    var title = '';
    switch (page) {
      case MainPageName.NODE_LIST:
        title = 'ノード';
        break;
      case MainPageName.ACCOUNT_LIST:
        title = 'アカウント';
        break;
    }
    return title;
  }
}
