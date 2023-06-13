import 'package:symbol_node_watcher/domain/entities/common/pagenation.dart';

class PagenationModel extends Pagenation {
  PagenationModel({
    required int pageNumber,
    required int pageSize,
  }) : super(
          pageNumber: pageNumber,
          pageSize: pageSize,
        );

  factory PagenationModel.fromJson(Map<String, dynamic> json) {
    return PagenationModel(
      pageNumber: json['pageNumber'],
      pageSize: json['pageSize'],
    );
  }
}
