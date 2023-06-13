import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:symbol_node_watcher/ui/pages/node_detail_page.dart';

class NodeInfoWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final nodeInfo = useProvider(nodeInfoScopedProvider);
    return Card(
      margin: EdgeInsets.fromLTRB(25, 25, 25, 0),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Host',
              style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5)),
            ),
            Text(nodeInfo.host, style: TextStyle(fontSize: 16)),
            Padding(padding: EdgeInsets.only(bottom: 15)),
            Text(
              'Friendly Name',
              style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5)),
            ),
            Text(nodeInfo.friendlyName, style: TextStyle(fontSize: 16)),
            Padding(padding: EdgeInsets.only(bottom: 15)),
            Text(
              'Public Key',
              style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5)),
            ),
            InkWell(
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      nodeInfo.publicKey,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Icon(
                    Icons.copy,
                    size: 16,
                  ),
                ],
              ),
              onTap: () async {
                final data = ClipboardData(text: nodeInfo.publicKey);
                await Clipboard.setData(data);
                Fluttertoast.showToast(
                  msg: 'コピーしました',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Color.fromRGBO(0x62, 0x00, 0xEE, 1.0),
                  textColor: Colors.white,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
