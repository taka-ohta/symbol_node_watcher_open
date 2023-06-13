import 'package:symbol_node_watcher/domain/entities/account/activity_bucket.dart';

class ActivityBucketListModel {
  final List<ActivityBucket> activityBuckets;
  ActivityBucketListModel({required this.activityBuckets});

  factory ActivityBucketListModel.fromJson(List json) {
    final List<ActivityBucket> activityBuckets = [];
    for (final activityBucket in json) {
      activityBuckets.add(ActivityBucket(
        startHeight: BigInt.parse(activityBucket['startHeight']),
        totalFeesPaid: activityBucket['totalFeesPaid'],
        beneficiaryCount: activityBucket['beneficiaryCount'],
        rawScore: BigInt.parse(activityBucket['rawScore']),
      ));
    }
    return ActivityBucketListModel(activityBuckets: activityBuckets);
  }
}
