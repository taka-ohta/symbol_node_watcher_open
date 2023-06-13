import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:symbol_node_watcher/domain/entities/setting/account_setting.dart';
import 'package:symbol_node_watcher/domain/entities/setting/node_setting.dart';
import 'package:symbol_node_watcher/domain/repositories/setting/setting_repository.dart';

class SettingRepositoryHive extends SettingRepository {
  @override
  Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(dir.path);
    Hive.registerAdapter(NodeSettingAdapter());
    await Hive.openBox('node_settings');
    await Hive.openBox('account_settings');
  }

  @override
  Future<void> addNodeSetting({
    required String host,
    required String name,
    required bool https,
    required bool notification,
  }) async {
    final box = Hive.box('node_settings');
    await box.add(NodeSetting(
      name: name,
      host: host,
      https: https,
      notification: notification,
    ));
  }

  @override
  Future<void> deleteNodeSetting({required String host}) async {
    final setting = this._getNodeSetting(host);
    if (setting != null) {
      await setting.delete();
    }
  }

  @override
  bool existsNodeSetting({required String host}) {
    final setting = this._getNodeSetting(host);
    return setting != null;
  }

  @override
  List<NodeSetting> getNodeSettings() {
    final box = Hive.box('node_settings');
    final list = box.values.toList().cast<NodeSetting>();
    return list;
  }

  @override
  Future<void> updateNodeSetting({
    required String host,
    required String name,
    required bool https,
    required bool notification,
  }) async {
    final setting = this._getNodeSetting(host);
    if (setting != null) {
      setting.host = host;
      setting.name = name;
      setting.https = https;
      setting.notification = notification;
      await setting.save();
    }
  }

  NodeSetting? _getNodeSetting(String host) {
    final list = this.getNodeSettings();
    for (final element in list) {
      if (element.host == host) {
        return element;
      }
    }
    return null;
  }

  @override
  Future<void> addAccountSetting(
      {required String address, required String name}) async {
    final box = Hive.box('account_settings');
    await box.add(AccountSetting(name: name, address: address));
  }

  @override
  Future<void> deleteAccountSetting({required String address}) async {
    final setting = this._getAccountSetting(address);
    if (setting != null) {
      await setting.delete();
    }
  }

  @override
  bool existsAccountSetting({required String address}) {
    final setting = this._getAccountSetting(address);
    return setting != null;
  }

  @override
  List<AccountSetting> getAccountSettings() {
    final box = Hive.box('account_settings');
    final list = box.values.toList().cast<AccountSetting>();
    return list;
  }

  @override
  Future<void> updateAccountSetting(
      {required String address, required String name}) async {
    final setting = this._getAccountSetting(address);
    if (setting != null) {
      setting.address = address;
      setting.name = name;
      await setting.save();
    }
  }

  AccountSetting? _getAccountSetting(String address) {
    final list = this.getAccountSettings();
    for (final element in list) {
      if (element.address == address) {
        return element;
      }
    }
    return null;
  }
}
