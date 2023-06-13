import 'package:symbol_node_watcher/domain/entities/node/node_info.dart';

class NodeInfoModel extends NodeInfo {
  NodeInfoModel({
    required int version,
    required String publicKey,
    required String networkGenerationHashSeed,
    required int roles,
    required int port,
    required int networkIdentifier,
    required String friendlyName,
    required String host,
    required String nodePublicKey,
  }) : super(
          version: version,
          publicKey: publicKey,
          networkGenerationHashSeed: networkGenerationHashSeed,
          roles: roles,
          port: port,
          networkIdentifier: networkIdentifier,
          friendlyName: friendlyName,
          host: host,
          nodePublicKey: nodePublicKey,
        );

  factory NodeInfoModel.fromJson(Map<String, dynamic> json) {
    return NodeInfoModel(
      version: json['version'],
      publicKey: json['publicKey'],
      networkGenerationHashSeed: json['networkGenerationHashSeed'],
      roles: json['roles'],
      port: json['port'],
      networkIdentifier: json['networkIdentifier'],
      friendlyName: json['friendlyName'],
      host: json['host'],
      nodePublicKey: json['nodePublicKey'],
    );
  }
}
