enum Order {
  Asc,
  Desc,
}

extension OrderExtension on Order {
  static final values = {
    Order.Asc: 'asc',
    Order.Desc: 'desc',
  };
  String get value => values[this]!;
}
