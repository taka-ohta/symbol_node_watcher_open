import 'package:symbol_node_watcher/domain/entities/account/account_type.dart';
import 'package:symbol_node_watcher/domain/entities/account/activity_bucket.dart';
import 'package:symbol_node_watcher/domain/entities/account/supplemental_public_keys.dart';
import 'package:symbol_node_watcher/domain/entities/common/address.dart';
import 'package:symbol_node_watcher/domain/entities/mosaic/mosaic.dart';

class AccountInfo {
  final int version;
  final Address address;
  final BigInt addressHeight;
  final String publicKey;
  final BigInt publicKeyHeight;
  final AccountType accountType;
  final SupplementalPublicKeys supplementalPublicKeys;
  final List<ActivityBucket> activityBuckets;
  final List<Mosaic> mosaics;
  final BigInt importance;
  final BigInt importanceHeight;
  AccountInfo({
    required this.version,
    required this.address,
    required this.addressHeight,
    required this.publicKey,
    required this.publicKeyHeight,
    required this.accountType,
    required this.supplementalPublicKeys,
    required this.activityBuckets,
    required this.mosaics,
    required this.importance,
    required this.importanceHeight,
  });
}
