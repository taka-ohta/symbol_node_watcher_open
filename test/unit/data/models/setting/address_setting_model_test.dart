import 'package:flutter_test/flutter_test.dart';
import 'package:symbol_node_watcher/data/models/setting/account_setting_model.dart';

void main() {
  group('address_setting_model', () {
    test('アドレス正常', () {
      expect(
        AccountSettingModel.validate(
            address: 'NBWOWL-DCIO5M-AESFXU-I5JOMS-ABZ5G2-MF4KZL-ZZA'),
        isTrue,
      );
      expect(
        AccountSettingModel.validate(
            address: 'NAX4EZ-A4MNTO-LCONCK-AB3JDU-IXVM74-IQWP3A-PUQ'),
        isTrue,
      );
    });
    test('アドレス異常(スペースあり)', () {
      expect(
          AccountSettingModel.validate(
              address: 'NAX4EZ A4MNTO LCONCK AB3JDU IXVM74 IQWP3A PUQ'),
          isFalse);
    });
    test('アドレス異常(全角文字あり)', () {
      expect(
          AccountSettingModel.validate(
              address: 'ＮAX４EZ-A4MNTO-LCONCK-AB3JDU-IXVM74-IQWP3A-PUQ'),
          isFalse);
    });
    test('アドレス異常(小文字あり)', () {
      expect(
          AccountSettingModel.validate(
              address: 'NBWOWL-DCIO5M-AESFXU-I5JOMS-ABZ5G2-MF4KZL-ZZa'),
          isFalse);
    });
    test('アドレス異常(-なし))', () {
      expect(
          AccountSettingModel.validate(
              address: 'NBWOWLDCIO5MAESFXUI5JOMSABZ5G2MF4KZLZZA'),
          isFalse);
    });
    test('アドレス異常(長さ不足))', () {
      expect(
          AccountSettingModel.validate(
              address: 'NBWOWL-DCIO5M-AESFXU-I5JOMS-ABZ5G2-MF4KZL-ZZ'),
          isFalse);
    });
    test('アドレス異常(長さ超過))', () {
      expect(
          AccountSettingModel.validate(
              address: 'NBWOWL-DCIO5M-AESFXU-I5JOMS-ABZ5G2-MF4KZL-ZZAAAA'),
          isFalse);
    });
  });
}
