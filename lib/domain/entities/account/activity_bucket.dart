class ActivityBucket {
  final BigInt startHeight;
  final String totalFeesPaid;
  final int beneficiaryCount;
  final BigInt rawScore;
  ActivityBucket({
    required this.startHeight,
    required this.totalFeesPaid,
    required this.beneficiaryCount,
    required this.rawScore,
  });
}
