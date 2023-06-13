import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:symbol_node_watcher/ui/pages/delegate_account_list_page.dart';

class DelegateAccountItemWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final account = useProvider(delegateAccountProvider);
    return Container(
      child: ListTile(
        title: Text('アドレス', style: TextStyle(fontSize: 12)),
        subtitle:
            Text(account.address.formatAddress, style: TextStyle(fontSize: 14)),
        trailing: Icon(
          Icons.copy,
          size: 16,
        ),
        onTap: () async {
          final data = ClipboardData(text: account.address.formatAddress);
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
    );
  }
}
