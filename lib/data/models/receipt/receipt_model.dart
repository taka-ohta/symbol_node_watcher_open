import 'package:symbol_node_watcher/data/models/receipt/inflation_receipt_model.dart';
import 'package:symbol_node_watcher/domain/entities/receipt/receipt.dart';
import 'package:symbol_node_watcher/domain/entities/receipt/receipt_type.dart';

class ReceiptModel extends Receipt {
  ReceiptModel({
    required int version,
    required ReceiptType type,
  }) : super(
          version: version,
          type: type,
        );
  static Receipt fromJson(Map<String, dynamic> json) {
    Receipt model;
    final type = ReceiptTypeExtension.getType(json['type']);
    switch (type) {
      case ReceiptType.Address_Alias_Resolution:
      case ReceiptType.Inflation:
      case ReceiptType.LockHash_Completed:
      case ReceiptType.LockHash_Created:
      case ReceiptType.LockHash_Expired:
      case ReceiptType.LockSecret_Completed:
      case ReceiptType.LockSecret_Created:
      case ReceiptType.LockSecret_Expired:
      case ReceiptType.Mosaic_Alias_Resolution:
      case ReceiptType.Mosaic_Expired:
      case ReceiptType.Mosaic_Levy:
      case ReceiptType.Mosaic_Rental_Fee:
      case ReceiptType.Namespace_Deleted:
      case ReceiptType.Namespace_Expired:
      case ReceiptType.Namespace_Rental_Fee:
      case ReceiptType.Transaction_Group:
        model = ReceiptModel(version: json['version'], type: type);
        break;
      case ReceiptType.Harvest_Fee:
        model = InflationReceiptModel.fromJson(json);
        break;
    }

    return model;
  }
}
