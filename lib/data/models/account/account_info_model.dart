import 'package:symbol_node_watcher/data/models/account/activity_bucket_list_model.dart';
import 'package:symbol_node_watcher/data/models/account/supplemental_public_keys_model.dart';
import 'package:symbol_node_watcher/data/models/common/address_model.dart';
import 'package:symbol_node_watcher/data/models/mosaic/mosaic_list_model.dart';
import 'package:symbol_node_watcher/domain/entities/account/account_info.dart';
import 'package:symbol_node_watcher/domain/entities/account/account_type.dart';
import 'package:symbol_node_watcher/domain/entities/account/supplemental_public_keys.dart';

class AccountInfoModel extends AccountInfo {
  AccountInfoModel({
    required int version,
    required String address,
    required BigInt addressHeight,
    required String publicKey,
    required BigInt publicKeyHeight,
    required AccountType accountType,
    required SupplementalPublicKeys supplementalPublicKeys,
    required ActivityBucketListModel activityBucketListModel,
    required MosaicListModel mosaicListModel,
    required BigInt importance,
    required BigInt importanceHeight,
  }) : super(
          version: version,
          address: AddressModel(rawAddress: address),
          addressHeight: addressHeight,
          publicKey: publicKey,
          publicKeyHeight: publicKeyHeight,
          accountType: accountType,
          supplementalPublicKeys: supplementalPublicKeys,
          activityBuckets: activityBucketListModel.activityBuckets,
          mosaics: mosaicListModel.mosaics,
          importance: importance,
          importanceHeight: importanceHeight,
        );

  factory AccountInfoModel.fromJson(Map<String, dynamic> json) {
    return AccountInfoModel(
      version: json['account']['version'],
      address: json['account']['address'],
      addressHeight: BigInt.parse(json['account']['addressHeight']),
      publicKey: json['account']['publicKey'],
      publicKeyHeight: BigInt.parse(json['account']['publicKeyHeight']),
      accountType: AccountTypeExtension.getType(json['account']['accountType']),
      supplementalPublicKeys: SupplementalPublicKeysModel.fromJson(
        json['account']['supplementalPublicKeys'],
      ),
      activityBucketListModel: ActivityBucketListModel.fromJson(
        json['account']['activityBuckets'],
      ),
      mosaicListModel: MosaicListModel.fromJson(json['account']['mosaics']),
      importance: BigInt.parse(json['account']['importance']),
      importanceHeight: BigInt.parse(json['account']['importanceHeight']),
    );
  }
}
