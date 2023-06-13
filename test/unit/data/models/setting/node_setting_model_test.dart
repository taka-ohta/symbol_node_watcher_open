import 'package:flutter_test/flutter_test.dart';
import 'package:symbol_node_watcher/data/models/setting/node_setting_model.dart';

void main() {
  group('node_setting_model', () {
    test('ホスト名正常', () {
      expect(NodeSettingModel.validate(host: 'localhost.com'), isTrue);
    });
    test('ホスト名異常(スペースあり)', () {
      expect(NodeSettingModel.validate(host: 'local host'), isFalse);
    });
    test('ホスト名異常(全角文字あり)', () {
      expect(NodeSettingModel.validate(host: 'localあhost'), isFalse);
    });
  });
}
