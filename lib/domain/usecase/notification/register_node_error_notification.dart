import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:symbol_node_watcher/di/dependency_injection.dart';
import 'package:symbol_node_watcher/domain/repositories/notification/notification_repository.dart';
import 'package:symbol_node_watcher/domain/usecase/base/usecase.dart';
import 'package:symbol_node_watcher/ui/widgets/ad/banner_ad_widget.dart';

class RegisterNodeErrorNotification extends UseCase<bool, BuildContext> {
  static const int ID = 0x01;
  @override
  Future<Stream<bool>> call(BuildContext context) async {
    final show = (String title, String body, String payload) {
      showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(title),
          content: Text(body),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Ok'),
              onPressed: () async {
                await Navigator.of(context).pushReplacementNamed('/');
              },
            )
          ],
        ),
      );
    };
    final select = () async {
      final provider = context.read(bannerAdProvider.notifier);
      await provider.disposeBanner();
      await Navigator.of(context).pushReplacementNamed('/');
    };

    final repository = getIt<NotificationRepository>();
    final controller = StreamController<bool>();
    repository.registerCallback(
      id: RegisterNodeErrorNotification.ID,
      show: show,
      select: select,
    );
    controller.add(true);
    controller.close();
    return controller.stream;
  }
}
