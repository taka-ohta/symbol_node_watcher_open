import 'package:symbol_node_watcher/domain/entities/account/unlocked_account.dart';

class UnlockedAccountListModel {
  final List<UnlockedAccount> accounts;
  UnlockedAccountListModel({required this.accounts});

  factory UnlockedAccountListModel.fromJson(Map<String, dynamic> json) {
    final List<UnlockedAccount> accounts = [];
    final list = json['unlockedAccount'] as List;
    for (final publicKey in list) {
      accounts.add(UnlockedAccount(publicKey: publicKey));
    }
    return UnlockedAccountListModel(accounts: accounts);
  }
}
