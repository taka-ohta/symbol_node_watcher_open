enum ReceiptType {
  Address_Alias_Resolution,
  Harvest_Fee,
  Inflation,
  LockHash_Completed,
  LockHash_Created,
  LockHash_Expired,
  LockSecret_Completed,
  LockSecret_Created,
  LockSecret_Expired,
  Mosaic_Alias_Resolution,
  Mosaic_Expired,
  Mosaic_Levy,
  Mosaic_Rental_Fee,
  Namespace_Deleted,
  Namespace_Expired,
  Namespace_Rental_Fee,
  Transaction_Group,
}

extension ReceiptTypeExtension on ReceiptType {
  static final values = {
    ReceiptType.Address_Alias_Resolution: 61763,
    ReceiptType.Harvest_Fee: 8515,
    ReceiptType.Inflation: 20803,
    ReceiptType.LockHash_Completed: 8776,
    ReceiptType.LockHash_Created: 12616,
    ReceiptType.LockHash_Expired: 9032,
    ReceiptType.LockSecret_Completed: 8786,
    ReceiptType.LockSecret_Created: 12626,
    ReceiptType.LockSecret_Expired: 9042,
    ReceiptType.Mosaic_Alias_Resolution: 62019,
    ReceiptType.Mosaic_Expired: 16717,
    ReceiptType.Mosaic_Levy: 4685,
    ReceiptType.Mosaic_Rental_Fee: 4685,
    ReceiptType.Namespace_Deleted: 16974,
    ReceiptType.Namespace_Expired: 16718,
    ReceiptType.Namespace_Rental_Fee: 4942,
    ReceiptType.Transaction_Group: 57667,
  };

  int get value => values[this]!;
  static ReceiptType getType(int num) {
    ReceiptType type = ReceiptType.Address_Alias_Resolution;
    values.forEach((key, value) {
      if (num == value) {
        type = key;
      }
    });
    return type;
  }
}
