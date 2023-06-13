import 'package:flutter_test/flutter_test.dart';

import 'package:symbol_node_watcher/data/models/node/node_health_model.dart';

void main() {
  test('JSONからの変換', () {
    var model = NodeHealthModel.fromJson({
      'status': {'apiNode': 'up', 'db': 'up'}
    });
    expect(model.apiNode, 'up');
    expect(model.db, 'up');
  });
}
