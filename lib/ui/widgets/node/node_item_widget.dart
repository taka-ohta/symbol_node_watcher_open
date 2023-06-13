import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:symbol_node_watcher/ui/presenters/node/node_presenter.dart';

import 'node_edit_dialog.dart';
import 'node_list_widget.dart';

class NodeItemWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final node = useProvider(nodeProvider);
    return ListTile(
      title: Text(node.name, style: TextStyle(fontSize: 20)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(node.host, style: TextStyle(fontSize: 12)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.circle,
                color: this._getStatusColor(node.status),
                size: 12,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  this._getStatusText(node.status) +
                      (node.status != NodeStatus.REFRESHING
                          ? ' - ' +
                              DateFormat('yyyy/MM/dd HH:mm:ss')
                                  .format(node.lastUpdated!)
                          : ''),
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.arrow_right),
        ],
      ),
      isThreeLine: true,
      onTap: () => {
        Navigator.of(context).pushNamed('/node_detail', arguments: node),
      },
      onLongPress: () => showDialog(
        context: context,
        builder: (context) => ProviderScope(
          overrides: [nodeProvider.overrideWithValue(node)],
          child: NodeEditDialog(),
        ),
      ),
    );
  }

  Color _getStatusColor(NodeStatus status) {
    switch (status) {
      case NodeStatus.OK:
        return Color.fromRGBO(0x00, 0xB3, 0xA6, 1.0);
      case NodeStatus.REFRESHING:
        return Color.fromRGBO(0x00, 0x00, 0x00, 0.6);
      case NodeStatus.ERROR:
        return Color.fromRGBO(0xB0, 0x00, 0x20, 1.0);
    }
  }

  String _getStatusText(NodeStatus status) {
    switch (status) {
      case NodeStatus.OK:
        return '正常';
      case NodeStatus.REFRESHING:
        return 'データ取得中';
      case NodeStatus.ERROR:
        return '異常発生中';
    }
  }
}
