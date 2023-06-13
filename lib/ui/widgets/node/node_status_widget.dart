import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:symbol_node_watcher/ui/widgets/node/node_list_widget.dart';

class NodeStatusWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final node = useProvider(nodeProvider);
    return Card(
      margin: EdgeInsets.fromLTRB(25, 25, 25, 0),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Table(
          columnWidths: const {
            0: FixedColumnWidth(128),
            1: FlexColumnWidth(),
          },
          children: [
            TableRow(
              children: [
                TableCell(
                  child: Text(
                    'API',
                    style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5)),
                  ),
                ),
                TableCell(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.circle,
                        color: this._getStatusColor(node.health?.apiNode),
                        size: 12,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          this._getStatusText(node.health?.apiNode),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: Text(
                    'DB',
                    style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5)),
                  ),
                ),
                TableCell(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.circle,
                        color: this._getStatusColor(node.health?.db),
                        size: 12,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          this._getStatusText(node.health?.db),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    if (status == 'up') {
      return Color.fromRGBO(0x00, 0xB3, 0xA6, 1.0);
    } else {
      return Color.fromRGBO(0xB0, 0x00, 0x20, 1.0);
    }
  }

  String _getStatusText(String? status) {
    if (status == 'up') {
      return '正常';
    } else {
      return '異常発生中';
    }
  }
}
