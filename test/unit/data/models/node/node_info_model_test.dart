import 'package:flutter_test/flutter_test.dart';

import 'package:symbol_node_watcher/data/models/node/node_info_model.dart';

void main() {
  test('JSONからの変換', () {
    var model = NodeInfoModel.fromJson({
      'version': 0,
      'publicKey':
          'AC1A6E1D8DE5B17D2C6B1293F1CAD3829EEACF38D09311BB3C8E5A880092DE26',
      'networkGenerationHashSeed':
          'C8FC3FB54FDDFBCE0E8C71224990124E4EEC5AD5D30E592EDFA9524669A23810',
      'roles': 7,
      'port': 7900,
      'networkIdentifier': 144,
      'friendlyName': 'api-node-0',
      'host': '127.0.0.1',
      'nodePublicKey':
          'AC1A6E1D8DE5B17D2C6B1293F1CAD3829EEACF38D09311BB3C8E5A880092DE26'
    });
    expect(model.version, 0);
    expect(model.publicKey,
        'AC1A6E1D8DE5B17D2C6B1293F1CAD3829EEACF38D09311BB3C8E5A880092DE26');
    expect(model.networkGenerationHashSeed,
        'C8FC3FB54FDDFBCE0E8C71224990124E4EEC5AD5D30E592EDFA9524669A23810');
    expect(model.roles, 7);
    expect(model.port, 7900);
    expect(model.networkIdentifier, 144);
    expect(model.friendlyName, 'api-node-0');
    expect(model.host, '127.0.0.1');
    expect(model.nodePublicKey,
        'AC1A6E1D8DE5B17D2C6B1293F1CAD3829EEACF38D09311BB3C8E5A880092DE26');
  });
}
