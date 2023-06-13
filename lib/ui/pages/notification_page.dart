import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:symbol_node_watcher/ui/pages/application_main_page.dart';
import 'package:symbol_node_watcher/ui/presenters/page/sub_page_presenter.dart';
import 'package:symbol_node_watcher/ui/widgets/app_bar/sub_app_bar.dart';

class NotificationPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    useEffect(() {
      Future.microtask(
        () => context
            .read(subPageProvider.notifier)
            .change(SubPageName.NOTIFICATION),
      );
    }, const []);
    return Scaffold(
      appBar: SubAppBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            new Expanded(
              child: Text('Notification page.'),
            ),
          ],
        ),
      ),
    );
  }
}
