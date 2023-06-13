import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:symbol_node_watcher/ui/pages/harvest_history_page.dart';
import 'package:url_launcher/url_launcher.dart';

class HarvestHistoryItemWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final harvestInfo = useProvider(harvestInfoProvider);
    return Container(
      child: ListTile(
        minVerticalPadding: 5,
        title: Row(
          children: [
            Expanded(
              child: Text(
                DateFormat('yyyy/MM/dd HH:mm:ss').format(harvestInfo.timestamp),
                style: TextStyle(fontSize: 14),
              ),
            ),
            Expanded(
              child: Text(
                harvestInfo.height.toString(),
                style: TextStyle(fontSize: 14),
              ),
            ),
            Expanded(
              child: Text(
                harvestInfo.amount.toXym(),
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        trailing: Icon(Icons.arrow_right),
        onTap: () async {
          final url =
              'http://explorer.symbolblockchain.io/blocks/${harvestInfo.height.toString()}';
          await canLaunch(url)
              ? await launch(url)
              : throw 'Could not launch $url';
        },
      ),
    );
  }
}
