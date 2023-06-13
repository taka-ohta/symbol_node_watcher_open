import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:symbol_node_watcher/domain/usecase/interval/register_check_node_health_interval_task.dart';
import 'package:symbol_node_watcher/domain/usecase/notification/register_node_error_notification.dart';
import 'package:symbol_node_watcher/ui/presenters/page/main_page_presenter.dart';
import 'package:symbol_node_watcher/ui/presenters/page/sub_page_presenter.dart';
// import 'package:symbol_node_watcher/ui/widgets/account/account_list_widget.dart';
import 'package:symbol_node_watcher/ui/widgets/app_bar/main_app_bar.dart';
import 'package:symbol_node_watcher/ui/widgets/node/node_add_dialog.dart';
import 'package:symbol_node_watcher/ui/widgets/node/node_list_widget.dart';

final mainPageProvider = StateNotifierProvider<MainPagePresenter, MainPageName>(
  (_) => MainPagePresenter(MainPageName.NODE_LIST),
);

final subPageProvider = StateNotifierProvider<SubPagePresenter, SubPageName>(
  (_) => SubPagePresenter(SubPageName.MAIN),
);

class ApplicationMainPage extends HookWidget {
  final _widgets = [
    NodeListWidget(),
    // AccountListWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    final page = useProvider(mainPageProvider);

    final registerNotification = RegisterNodeErrorNotification();
    registerNotification.call(context);

    final registerInterval = RegisterCheckNodeHealthIntervalTask();
    registerInterval(null);

    return Scaffold(
      appBar: MainAppBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            new Expanded(
              // child: _widgets[page.index],
              child: _widgets[0],
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Theme.of(context).primaryColor,
      //   selectedItemColor: Colors.white,
      //   unselectedItemColor: Color.fromRGBO(0xff, 0xff, 0xff, 0.5),
      //   showSelectedLabels: false,
      //   showUnselectedLabels: false,
      //   currentIndex: page.index,
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.dns),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.account_circle),
      //       label: '',
      //     ),
      //   ],
      //   onTap: (index) {
      //     context
      //         .read(mainPageProvider.notifier)
      //         .change(MainPageName.values[index]);
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {
          if (page == MainPageName.NODE_LIST)
            {
              showDialog(
                context: context,
                builder: (context) => NodeAddDialog(),
              )
            }
        },
      ),
    );
  }
}
