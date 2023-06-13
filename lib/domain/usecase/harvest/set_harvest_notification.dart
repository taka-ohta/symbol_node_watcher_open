import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:symbol_node_watcher/di/dependency_injection.dart';
import 'package:symbol_node_watcher/domain/entities/common/host.dart';
import 'package:symbol_node_watcher/domain/repositories/harvesting/harvesting_repository.dart';
import 'package:symbol_node_watcher/domain/usecase/account/get_main_account_info.dart';
import 'package:symbol_node_watcher/domain/usecase/base/usecase.dart';
import 'package:symbol_node_watcher/domain/usecase/node/get_node_info.dart';

class SetHarvestNotificationParam {
  Host host;
  bool enable;
  SetHarvestNotificationParam({required this.host, required this.enable});
}

class SetHarvestNotification
    extends UseCase<void, SetHarvestNotificationParam> {
  @override
  Future<Stream<void>> call(SetHarvestNotificationParam params) async {
    final controller = StreamController<bool>();
    try {
      final token = await FirebaseMessaging.instance.getToken();
      final usecase = GetNodeInfo();
      final stream = await usecase.call(params.host);
      stream.listen((nodeInfo) async {
        if (nodeInfo != null) {
          final usecase = GetMainAccountInfo();
          final stream = await usecase.call(GetMainAccountInfoParam(
            host: params.host,
            publicKey: nodeInfo.publicKey,
          ));
          stream.listen((data) async {
            final repository = getIt<HarvestingRepository>();
            final address = data.address.base32Address;
            if (params.enable) {
              await repository.setAddress(address, token!);
            } else {
              await repository.deleteAddress(address, token!);
            }
          });
        }
      });
    } catch (_) {}
    controller.close();
    return controller.stream;
  }
}
