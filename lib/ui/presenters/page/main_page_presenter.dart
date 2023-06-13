import 'package:hooks_riverpod/hooks_riverpod.dart';

enum MainPageName {
  NODE_LIST,
  ACCOUNT_LIST,
}

class MainPagePresenter extends StateNotifier<MainPageName> {
  MainPagePresenter(MainPageName page) : super(page);
  void change(MainPageName page) => this.state = page;
}
