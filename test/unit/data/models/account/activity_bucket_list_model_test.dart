import 'package:flutter_test/flutter_test.dart';
import 'package:symbol_node_watcher/data/models/account/activity_bucket_list_model.dart';

void main() {
  group('activity_bucket_list_model_test', () {
    test('JSONからの変換', () {
      var model = ActivityBucketListModel.fromJson([
        {
          "startHeight": "90720",
          "totalFeesPaid": "0",
          "beneficiaryCount": 0,
          "rawScore": "959010217328"
        },
        {
          "startHeight": "90000",
          "totalFeesPaid": "0",
          "beneficiaryCount": 1,
          "rawScore": "958984502185"
        },
        {
          "startHeight": "89280",
          "totalFeesPaid": "0",
          "beneficiaryCount": 0,
          "rawScore": "959006419519"
        },
        {
          "startHeight": "88560",
          "totalFeesPaid": "0",
          "beneficiaryCount": 0,
          "rawScore": "959021160768"
        },
        {
          "startHeight": "87840",
          "totalFeesPaid": "0",
          "beneficiaryCount": 0,
          "rawScore": "959037802212"
        }
      ]);
      expect(model.activityBuckets.length, 5);

      expect(
        model.activityBuckets[0].startHeight.toUnsigned(64),
        BigInt.from(90720),
      );
      expect(model.activityBuckets[0].totalFeesPaid, '0');
      expect(model.activityBuckets[0].beneficiaryCount, 0);
      expect(
        model.activityBuckets[0].rawScore.toUnsigned(64),
        BigInt.from(959010217328),
      );

      expect(
        model.activityBuckets[1].startHeight.toUnsigned(64),
        BigInt.from(90000),
      );
      expect(model.activityBuckets[1].totalFeesPaid, '0');
      expect(model.activityBuckets[1].beneficiaryCount, 1);
      expect(
        model.activityBuckets[1].rawScore.toUnsigned(64),
        BigInt.from(958984502185),
      );

      expect(
        model.activityBuckets[2].startHeight.toUnsigned(64),
        BigInt.from(89280),
      );
      expect(model.activityBuckets[2].totalFeesPaid, '0');
      expect(model.activityBuckets[2].beneficiaryCount, 0);
      expect(
        model.activityBuckets[2].rawScore.toUnsigned(64),
        BigInt.from(959006419519),
      );

      expect(
        model.activityBuckets[3].startHeight.toUnsigned(64),
        BigInt.from(88560),
      );
      expect(model.activityBuckets[3].totalFeesPaid, '0');
      expect(model.activityBuckets[3].beneficiaryCount, 0);
      expect(
        model.activityBuckets[3].rawScore.toUnsigned(64),
        BigInt.from(959021160768),
      );

      expect(
        model.activityBuckets[4].startHeight.toUnsigned(64),
        BigInt.from(87840),
      );
      expect(model.activityBuckets[4].totalFeesPaid, '0');
      expect(model.activityBuckets[4].beneficiaryCount, 0);
      expect(
        model.activityBuckets[4].rawScore.toUnsigned(64),
        BigInt.from(959037802212),
      );
    });
  });
}
