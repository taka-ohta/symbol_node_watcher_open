import 'package:symbol_node_watcher/domain/entities/common/amount.dart';

class AmountModel extends Amount {
  AmountModel({required String amount}) : super(amount: BigInt.parse(amount));
}
