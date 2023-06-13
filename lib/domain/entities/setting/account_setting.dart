import 'package:hive/hive.dart';

part 'account_setting.g.dart';

@HiveType(typeId: 1)
class AccountSetting extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String address;
  AccountSetting({required this.name, required this.address});
}
