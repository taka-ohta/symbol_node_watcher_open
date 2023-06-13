class Amount {
  final BigInt amount;
  Amount({required this.amount});
  String toXym() {
    return (this.amount.toDouble() / 1000000).toString() + 'XYM';
  }
}
