import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:symbol_node_watcher/di/dependency_injection.dart';
import 'package:symbol_node_watcher/domain/repositories/interval_task/intarval_task_repository.dart';
import 'package:symbol_node_watcher/domain/repositories/notification/notification_repository.dart';
import 'package:symbol_node_watcher/domain/repositories/setting/setting_repository.dart';
import 'package:symbol_node_watcher/ui/pages/application_main_page.dart';
import 'package:symbol_node_watcher/ui/pages/delegate_account_list_page.dart';
import 'package:symbol_node_watcher/ui/pages/harvest_history_page.dart';
import 'package:symbol_node_watcher/ui/pages/node_detail_page.dart';
import 'package:symbol_node_watcher/ui/pages/notification_page.dart';
import 'package:symbol_node_watcher/ui/pages/setting_page.dart';
import 'package:symbol_node_watcher/ui/widgets/ad/banner_ad_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting("ja_JP");
  initDependencyInjection();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.requestPermission();
  runZonedGuarded(() async {
    MobileAds.instance.initialize();
    await getIt<SettingRepository>().initialize();
    await getIt<IntervalTaskRepository>().initialize();
    await getIt<NotificationRepository>().initialize();
    runApp(ProviderScope(child: SymbolNodeWatcher()));
  }, FirebaseCrashlytics.instance.recordError);
}

class SymbolNodeWatcher extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Symbol Node Watcher',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color.fromRGBO(0x62, 0x00, 0xEE, 1.0),
        accentColor: Color.fromRGBO(0xFF, 0x00, 0xFF, 1.0),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Column(
              children: [
                Expanded(child: ApplicationMainPage()),
                BannerAdWidget(),
              ],
            ),
        '/node_detail': (context) => NodeDetailPage(),
        '/notification': (context) => NotificationPage(),
        '/setting': (context) => SettingPage(),
        '/delegate_account_list': (context) => DelegateAccountListPage(),
        '/harvest_history': (context) => HarvestHistoryPage(),
      },
    );
  }
}
