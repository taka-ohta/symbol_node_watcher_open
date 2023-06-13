import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

import 'package:symbol_node_watcher/data/repositories/symbol/node_repository_http.dart';
import 'package:symbol_node_watcher/domain/entities/common/host.dart';

void main() {
  test('ノード情報取得 正常取得(200)', () async {
    var mockClient = MockClient((request) async {
      expect(request.url.toString(), 'http://localhost:3000/node/info');
      return Response(
          json.encode({
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
          }),
          200);
    });
    var node = NodeRepositoryHttp(host: Host(host: 'localhost', https: false));
    node.client = mockClient;
    var status = await node.getNodeInfo();
    expect(status, isNotNull);
    if (status != null) {
      expect(status.version, 0);
      expect(status.publicKey,
          'AC1A6E1D8DE5B17D2C6B1293F1CAD3829EEACF38D09311BB3C8E5A880092DE26');
      expect(status.networkGenerationHashSeed,
          'C8FC3FB54FDDFBCE0E8C71224990124E4EEC5AD5D30E592EDFA9524669A23810');
      expect(status.roles, 7);
      expect(status.port, 7900);
      expect(status.networkIdentifier, 144);
      expect(status.friendlyName, 'api-node-0');
      expect(status.host, '127.0.0.1');
      expect(status.nodePublicKey,
          'AC1A6E1D8DE5B17D2C6B1293F1CAD3829EEACF38D09311BB3C8E5A880092DE26');
    }
  });
  test('ノード情報取得 タイムアウト', () async {
    var mockClient = MockClient((request) async {
      expect(request.url.toString(), 'http://localhost:3000/node/info');
      await Future.delayed(new Duration(seconds: 10));
      return Response(
          json.encode({
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
          }),
          200);
    });
    var node = NodeRepositoryHttp(host: Host(host: 'localhost', https: false));
    node.client = mockClient;
    var status = await node.getNodeInfo(timeOut: 5);
    expect(status, isNull);
  });
  test('ノード状態取得 正常取得(200)', () async {
    var mockClient = MockClient((request) async {
      expect(request.url.toString(), 'http://localhost:3000/node/health');
      return Response(
          json.encode({
            'status': {'apiNode': 'up', 'db': 'up'}
          }),
          200);
    });
    var node = NodeRepositoryHttp(host: Host(host: 'localhost', https: false));
    node.client = mockClient;
    var status = await node.getNodeHealth();
    expect(status, isNotNull);
    if (status != null) {
      expect(status.apiNode, 'up');
      expect(status.db, 'up');
    }
  });
  test('ノード状態取得 サーバ停止(503)', () async {
    var mockClient = MockClient((request) async {
      expect(request.url.toString(), 'http://localhost:3000/node/health');
      return Response(json.encode({}), 503);
    });
    var node = NodeRepositoryHttp(host: Host(host: 'localhost', https: false));
    node.client = mockClient;
    var status = await node.getNodeHealth();
    expect(status, isNull);
  });
  test('ノード状態取得 タイムアウト', () async {
    var mockClient = MockClient((request) async {
      expect(request.url.toString(), 'http://localhost:3000/node/health');
      await Future.delayed(new Duration(seconds: 10));
      return Response(
          json.encode({
            'status': {'apiNode': 'up', 'db': 'up'}
          }),
          200);
    });
    var node = NodeRepositoryHttp(host: Host(host: 'localhost', https: false));
    node.client = mockClient;
    var status = await node.getNodeHealth(timeOut: 5);
    expect(status, isNull);
  });
}
