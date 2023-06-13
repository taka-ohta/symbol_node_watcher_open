import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:symbol_node_watcher/di/dependency_injection.dart';
import 'package:symbol_node_watcher/domain/entities/common/host.dart';
import 'package:symbol_node_watcher/domain/repositories/setting/setting_repository.dart';
import 'package:symbol_node_watcher/domain/usecase/harvest/set_harvest_notification.dart';
import 'package:symbol_node_watcher/ui/widgets/node/node_list_widget.dart';

class NodeEditDialog extends HookWidget {
  final _form = GlobalKey<FormState>();
  final _nameField = FocusNode();

  @override
  Widget build(BuildContext context) {
    final node = useProvider(nodeProvider);
    final name = useState(node.name);
    final https = useState(node.https);
    final notification = useState(node.notification);
    return AlertDialog(
      title: Text('監視ノード編集'),
      insetPadding: EdgeInsets.all(20),
      content: Container(
        width: 1000,
        child: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              children: [
                TextFormField(
                  autocorrect: false,
                  decoration: InputDecoration(labelText: 'ホスト(編集不可)'),
                  initialValue: node.host,
                  readOnly: true,
                ),
                TextFormField(
                  autocorrect: false,
                  decoration: InputDecoration(labelText: 'ノード名称(任意)'),
                  focusNode: _nameField,
                  initialValue: name.value,
                  onSaved: (value) {
                    if (value != null) {
                      name.value = value;
                    }
                  },
                ),
                SwitchListTile(
                  title: Text('HTTPS'),
                  value: https.value,
                  onChanged: (value) {
                    https.value = value;
                  },
                ),
                SwitchListTile(
                  title: Text('ハーベスト通知'),
                  value: notification.value,
                  onChanged: (value) {
                    notification.value = value;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text('削除'),
          onPressed: () async {
            await getIt<SettingRepository>().deleteNodeSetting(host: node.host);
            context.read(nodeListProvider.notifier).request();
            final usecase = SetHarvestNotification();
            usecase.call(SetHarvestNotificationParam(
              host: Host(host: node.host, https: https.value),
              enable: false,
            ));
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('更新'),
          onPressed: () async {
            if (_form.currentState!.validate()) {
              _form.currentState!.save();
              await getIt<SettingRepository>().updateNodeSetting(
                host: node.host,
                name: name.value,
                https: https.value,
                notification: notification.value,
              );
              context.read(nodeListProvider.notifier).request();
              final usecase = SetHarvestNotification();
              usecase.call(SetHarvestNotificationParam(
                host: Host(host: node.host, https: https.value),
                enable: notification.value,
              ));
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
