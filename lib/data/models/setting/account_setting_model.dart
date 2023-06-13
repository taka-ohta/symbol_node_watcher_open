import 'package:symbol_node_watcher/domain/entities/setting/account_setting.dart';

class AccountSettingModel extends AccountSetting {
  AccountSettingModel({
    required String name,
    required String address,
  }) : super(
          name: name,
          address: address,
        );
  static bool validate({required String? address}) {
    if (address == null || address == '') {
      return false;
    } else if (!RegExp(r'^(([A-Z0-9]{6}-){6}[A-Z0-9]{3})$').hasMatch(address)) {
      return false;
    }
    return true;
  }
}
