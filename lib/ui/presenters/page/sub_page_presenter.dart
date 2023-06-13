import 'package:hooks_riverpod/hooks_riverpod.dart';

enum SubPageName {
  MAIN,
  NODE_DETAIL,
  NOTIFICATION,
  SETTING,
  DELEGATE_ACCOUNT_LIST,
  HISTORY_INFLATION_RECEIPT_LIST,
}

class SubPagePresenter extends StateNotifier<SubPageName> {
  SubPagePresenter(SubPageName page) : super(page);
  void change(SubPageName page) => this.state = page;
}
