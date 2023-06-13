import 'package:symbol_node_watcher/domain/entities/account/supplemental_public_keys.dart';

class SupplementalPublicKeysModel extends SupplementalPublicKeys {
  SupplementalPublicKeysModel({
    String? linked,
    String? node,
    String? voting,
    String? vrf,
  }) : super(linked: linked, node: node, voting: voting, vrf: vrf);

  factory SupplementalPublicKeysModel.fromJson(Map<String, dynamic> json) {
    final linked = json['linked'];
    final node = json['node'];
    final voting = json['voting'];
    final vrf = json['vrf'];
    return SupplementalPublicKeysModel(
      linked: linked != null ? linked['publicKey'] : null,
      node: node != null ? node['publicKey'] : null,
      voting: voting != null ? voting['publicKey'] : null,
      vrf: vrf != null ? vrf['publicKey'] : null,
    );
  }
}
