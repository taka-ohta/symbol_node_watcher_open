import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:symbol_node_watcher/data/models/setting/node_setting_model.dart';
import 'package:symbol_node_watcher/di/dependency_injection.dart';
import 'package:symbol_node_watcher/domain/entities/common/host.dart';
import 'package:symbol_node_watcher/domain/repositories/setting/setting_repository.dart';
import 'package:symbol_node_watcher/domain/usecase/harvest/set_harvest_notification.dart';
import 'package:symbol_node_watcher/ui/widgets/node/node_list_widget.dart';

class NodeAddDialog extends HookWidget {
  final _form = GlobalKey<FormState>();
  final _nameField = FocusNode();

  @override
  Widget build(BuildContext context) {
    final name = useState('');
    final host = useState('');
    final https = useState(false);
    final notification = useState(false);
    return AlertDialog(
      title: Text('監視ノード追加'),
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
                  decoration: InputDecoration(labelText: 'ホスト(必須)'),
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_nameField),
                  onSaved: (value) {
                    if (value != null) {
                      host.value = value;
                    }
                  },
                  validator: (value) {
                    if (!NodeSettingModel.validate(host: value)) {
                      return '正しく入力してください';
                    } else if (getIt<SettingRepository>()
                        .existsNodeSetting(host: value!)) {
                      return 'すでに登録されています';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  autocorrect: false,
                  decoration: InputDecoration(labelText: 'ノード名称(任意)'),
                  focusNode: _nameField,
                  textInputAction: TextInputAction.next,
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
          child: Text('キャンセル'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text('追加'),
          onPressed: () async {
            if (_form.currentState!.validate()) {
              _form.currentState!.save();
              getIt<SettingRepository>().addNodeSetting(
                host: host.value,
                name: name.value,
                https: https.value,
                notification: notification.value,
              );
              context.read(nodeListProvider.notifier).request();
              final usecase = SetHarvestNotification();
              usecase.call(SetHarvestNotificationParam(
                host: Host(host: host.value, https: https.value),
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
