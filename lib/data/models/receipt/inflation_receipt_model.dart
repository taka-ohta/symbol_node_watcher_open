import 'package:symbol_node_watcher/data/models/common/address_model.dart';
import 'package:symbol_node_watcher/data/models/common/amount_model.dart';
import 'package:symbol_node_watcher/domain/entities/receipt/inflation_receipt.dart';
import 'package:symbol_node_watcher/domain/entities/receipt/receipt_type.dart';

class InflationReceiptModel extends InflationReceipt {
  InflationReceiptModel({
    required int version,
    required ReceiptType type,
    required AddressModel targetAddress,
    required mosaicId,
    required AmountModel amount,
  }) : super(
          version: version,
          type: type,
          targetAddress: targetAddress,
          mosaicId: mosaicId,
          amount: amount,
        );

  factory InflationReceiptModel.fromJson(Map<String, dynamic> json) {
    return InflationReceiptModel(
      version: json['version'],
      type: ReceiptTypeExtension.getType(json['type']),
      targetAddress: AddressModel(rawAddress: json['targetAddress']),
      mosaicId: json['mosaicId'],
      amount: AmountModel(amount: json['amount']),
    );
  }
}
