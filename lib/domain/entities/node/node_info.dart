class NodeInfo {
  final int version;
  final String publicKey;
  final String networkGenerationHashSeed;
  final int roles;
  final int port;
  final int networkIdentifier;
  final String friendlyName;
  final String host;
  final String nodePublicKey;

  NodeInfo({
    required this.version,
    required this.publicKey,
    required this.networkGenerationHashSeed,
    required this.roles,
    required this.port,
    required this.networkIdentifier,
    required this.friendlyName,
    required this.host,
    required this.nodePublicKey,
  });
}
