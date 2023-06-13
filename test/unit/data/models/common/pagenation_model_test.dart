import 'package:flutter_test/flutter_test.dart';
import 'package:symbol_node_watcher/data/models/common/pagenation_model.dart';

void main() {
  group('pagenation_model', () {
    test('JSONからの変換', () {
      var model = PagenationModel.fromJson({
        "pageNumber": 1,
        "pageSize": 20,
      });
      expect(model.pageNumber, 1);
      expect(model.pageSize, 20);
    });
  });
}
