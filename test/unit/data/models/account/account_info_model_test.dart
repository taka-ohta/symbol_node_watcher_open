import 'package:flutter_test/flutter_test.dart';
import 'package:symbol_node_watcher/data/models/account/account_info_model.dart';
import 'package:symbol_node_watcher/domain/entities/account/account_type.dart';

void main() {
  group('account_info_model_test', () {
    test('JSONからの変換', () {
      var model = AccountInfoModel.fromJson({
        "account": {
          "version": 1,
          "address": "689314BECD63248727B9E3A40BEA8E66AC0FD60C2826FFA8",
          "addressHeight": "16471",
          "publicKey":
              "FECDEE578EBC5810420C1068B3B46D4ED11C9F66EA9390D5201CEA10FE42037D",
          "publicKeyHeight": "16477",
          "accountType": 1,
          "supplementalPublicKeys": {
            "linked": {
              "publicKey":
                  "979D6A42269F92DE524267FA4196AFD3BD94A938400E23970D9786D7DE92B253"
            },
            "vrf": {
              "publicKey":
                  "07B8C7942C4049BFB393241C80064EA1EB75C2674C343811B2481943E19CFB3A"
            }
          },
          "activityBuckets": [
            {
              "startHeight": "95040",
              "totalFeesPaid": "0",
              "beneficiaryCount": 0,
              "rawScore": "1031750429291"
            },
            {
              "startHeight": "94320",
              "totalFeesPaid": "0",
              "beneficiaryCount": 0,
              "rawScore": "1031768473399"
            },
            {
              "startHeight": "93600",
              "totalFeesPaid": "0",
              "beneficiaryCount": 0,
              "rawScore": "1031786282725"
            },
            {
              "startHeight": "92880",
              "totalFeesPaid": "0",
              "beneficiaryCount": 0,
              "rawScore": "1031806192949"
            },
            {
              "startHeight": "92160",
              "totalFeesPaid": "0",
              "beneficiaryCount": 0,
              "rawScore": "1031821460340"
            }
          ],
          "mosaics": [
            {"id": "6BED913FA20223F8", "amount": "1084764052752"}
          ],
          "importance": "1031750429291",
          "importanceHeight": "95040"
        },
        "id": "605B16AFF78BBA71D7A922E6"
      });
      expect(model.version, 1);
      expect(model.address.rawAddress,
          '689314BECD63248727B9E3A40BEA8E66AC0FD60C2826FFA8');
      expect(model.addressHeight, BigInt.from(16471));
      expect(
        model.publicKey,
        'FECDEE578EBC5810420C1068B3B46D4ED11C9F66EA9390D5201CEA10FE42037D',
      );
      expect(model.publicKeyHeight, BigInt.from(16477));
      expect(model.accountType, AccountType.Main);
      expect(model.supplementalPublicKeys.linked, isNotNull);
      expect(
        model.supplementalPublicKeys.linked,
        '979D6A42269F92DE524267FA4196AFD3BD94A938400E23970D9786D7DE92B253',
      );
      expect(model.supplementalPublicKeys.node, isNull);
      expect(model.supplementalPublicKeys.voting, isNull);
      expect(model.supplementalPublicKeys.vrf, isNotNull);
      expect(
        model.supplementalPublicKeys.vrf,
        '07B8C7942C4049BFB393241C80064EA1EB75C2674C343811B2481943E19CFB3A',
      );
      expect(model.activityBuckets.length, 5);

      expect(
        model.activityBuckets[0].startHeight.toUnsigned(64),
        BigInt.from(95040),
      );
      expect(model.activityBuckets[0].totalFeesPaid, '0');
      expect(model.activityBuckets[0].beneficiaryCount, 0);
      expect(
        model.activityBuckets[0].rawScore.toUnsigned(64),
        BigInt.from(1031750429291),
      );

      expect(
        model.activityBuckets[1].startHeight.toUnsigned(64),
        BigInt.from(94320),
      );
      expect(model.activityBuckets[1].totalFeesPaid, '0');
      expect(model.activityBuckets[1].beneficiaryCount, 0);
      expect(
        model.activityBuckets[1].rawScore.toUnsigned(64),
        BigInt.from(1031768473399),
      );

      expect(
        model.activityBuckets[2].startHeight.toUnsigned(64),
        BigInt.from(93600),
      );
      expect(model.activityBuckets[2].totalFeesPaid, '0');
      expect(model.activityBuckets[2].beneficiaryCount, 0);
      expect(
        model.activityBuckets[2].rawScore.toUnsigned(64),
        BigInt.from(1031786282725),
      );

      expect(
        model.activityBuckets[3].startHeight.toUnsigned(64),
        BigInt.from(92880),
      );
      expect(model.activityBuckets[3].totalFeesPaid, '0');
      expect(model.activityBuckets[3].beneficiaryCount, 0);
      expect(
        model.activityBuckets[3].rawScore.toUnsigned(64),
        BigInt.from(1031806192949),
      );

      expect(
        model.activityBuckets[4].startHeight.toUnsigned(64),
        BigInt.from(92160),
      );
      expect(model.activityBuckets[4].totalFeesPaid, '0');
      expect(model.activityBuckets[4].beneficiaryCount, 0);
      expect(
        model.activityBuckets[4].rawScore.toUnsigned(64),
        BigInt.from(1031821460340),
      );
      expect(model.mosaics.length, 1);
      expect(model.mosaics[0].id, '6BED913FA20223F8');
      expect(
        model.mosaics[0].amount.amount.toUnsigned(64),
        BigInt.from(1084764052752),
      );
      expect(model.importance, BigInt.from(1031750429291));
      expect(model.importanceHeight, BigInt.from(95040));
    });
  });
}
