import 'package:symbol_node_watcher/domain/entities/setting/account_setting.dart';
import 'package:symbol_node_watcher/domain/entities/setting/node_setting.dart';

abstract class SettingRepository {
  Future<void> initialize();
  Future<void> addNodeSetting({
    required String host,
    required String name,
    required bool https,
    required bool notification,
  });
  Future<void> deleteNodeSetting({required String host});
  bool existsNodeSetting({required String host});
  List<NodeSetting> getNodeSettings();
  Future<void> updateNodeSetting({
    required String host,
    required String name,
    required bool https,
    required bool notification,
  });
  Future<void> addAccountSetting(
      {required String address, required String name});
  Future<void> deleteAccountSetting({required String address});
  bool existsAccountSetting({required String address});
  List<AccountSetting> getAccountSettings();
  Future<void> updateAccountSetting(
      {required String address, required String name});
}
