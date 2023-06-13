import 'package:symbol_node_watcher/domain/entities/receipt/receipt_source.dart';

class ReceiptSourceModel extends ReceiptSource {
  ReceiptSourceModel({required int primaryId, required int secondaryId})
      : super(
          primaryId: primaryId,
          secondaryId: secondaryId,
        );
  factory ReceiptSourceModel.fromJson(Map<String, dynamic> json) {
    return ReceiptSourceModel(
      primaryId: json['primaryId'],
      secondaryId: json['secondaryId'],
    );
  }
}
