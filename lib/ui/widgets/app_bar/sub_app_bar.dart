import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:symbol_node_watcher/ui/pages/application_main_page.dart';
import 'package:symbol_node_watcher/ui/presenters/page/sub_page_presenter.dart';

class SubAppBar extends HookWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final page = useProvider(subPageProvider);
    return AppBar(
      centerTitle: false,
      title: Text(this._getTitle(page)),
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_left),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  String _getTitle(SubPageName page) {
    var title = '';
    switch (page) {
      case SubPageName.MAIN:
        title = '';
        break;
      case SubPageName.NODE_DETAIL:
        title = 'ノード詳細';
        break;
      case SubPageName.SETTING:
        title = '設定';
        break;
      case SubPageName.NOTIFICATION:
        title = 'お知らせ';
        break;
      case SubPageName.DELEGATE_ACCOUNT_LIST:
        title = '委任アドレス一覧';
        break;
      case SubPageName.HISTORY_INFLATION_RECEIPT_LIST:
        title = 'ハーベスト履歴';
        break;
    }
    return title;
  }
}
