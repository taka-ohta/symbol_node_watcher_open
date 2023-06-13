import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:symbol_node_watcher/di/dependency_injection.dart';
import 'package:symbol_node_watcher/domain/entities/setting/node_setting.dart';
import 'package:symbol_node_watcher/domain/repositories/setting/setting_repository.dart';
import 'package:symbol_node_watcher/domain/usecase/node/get_node_list.dart';

import 'get_node_list_test.mocks.dart';

@GenerateMocks([SettingRepository])
void main() {
  group('get_node_list', () {
    final mock = MockSettingRepository();
    getIt.registerSingleton<SettingRepository>(mock);
    test('取得正常', () async {
      final ret = [
        NodeSetting(
          host: 'local1',
          name: 't1',
          https: false,
          notification: false,
        ),
        NodeSetting(
          host: 'local2',
          name: 't2',
          https: true,
          notification: false,
        ),
        NodeSetting(
          host: 'local3',
          name: 't3',
          https: false,
          notification: true,
        ),
        NodeSetting(
          host: 'local4',
          name: 't4',
          https: true,
          notification: true,
        ),
      ];
      when(mock.getNodeSettings()).thenAnswer((_) => ret);
      final usecase = GetNodeList();
      final stream = await usecase.call(null);
      stream.listen((data) {
        expect(data, isList);
        expect(data.length, 4);
        expect(data[0].host, 'local1');
        expect(data[0].name, 't1');
        expect(data[0].https, false);
        expect(data[0].notification, false);
        expect(data[1].host, 'local2');
        expect(data[1].name, 't2');
        expect(data[1].https, true);
        expect(data[1].notification, false);
        expect(data[2].host, 'local3');
        expect(data[2].name, 't3');
        expect(data[2].https, false);
        expect(data[2].notification, true);
        expect(data[3].host, 'local4');
        expect(data[3].name, 't4');
        expect(data[3].https, true);
        expect(data[3].notification, true);
      });
    });
    test('取得異常', () async {
      when(mock.getNodeSettings()).thenThrow(NullThrownError());
      final usecase = GetNodeList();
      final stream = await usecase.call(null);
      stream.listen((data) {
        expect(data, isList);
        expect(data.length, 0);
      });
    });
  });
}
