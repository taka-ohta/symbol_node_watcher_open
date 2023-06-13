import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:symbol_node_watcher/domain/repositories/notification/notification_repository.dart';

class NotificationRepositoryLocal extends NotificationRepository {
  static const _CHANNEL_ID = 'symbol_node_watcher';
  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final _showCallbackTable = Map<int, Function>();
  final _selectCallbackTable = Map<int, Function>();

  @override
  Future<void> initialize() async {
    final androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOsSetting = IOSInitializationSettings(
      onDidReceiveLocalNotification: this._onDidReceiveLocalNotification,
    );
    final settings = InitializationSettings(
      android: androidSetting,
      iOS: iOsSetting,
    );
    this._flutterLocalNotificationsPlugin.initialize(
          settings,
          onSelectNotification: this._selectNotification,
        );
  }

  @override
  Future<void> notify({
    required int id,
    required String title,
    required String body,
  }) async {
    const androidSpec = AndroidNotificationDetails(
      NotificationRepositoryLocal._CHANNEL_ID,
      'プッシュ通知',
      'プッシュを通知を行います。',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );
    const iOsSpec = IOSNotificationDetails(
      threadIdentifier: NotificationRepositoryLocal._CHANNEL_ID,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidSpec,
      iOS: iOsSpec,
    );
    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: id.toString(),
    );
  }

  @override
  void registerCallback({
    required int id,
    required Function show,
    required Function select,
  }) {
    _showCallbackTable[id] = show;
    _selectCallbackTable[id] = select;
  }

  @override
  void unRegisterCallback({required int id}) {
    _showCallbackTable.remove(id);
    _selectCallbackTable.remove(id);
  }

  Future<dynamic> _onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    if (this._showCallbackTable.containsKey(id)) {
      final callback = this._showCallbackTable[id];
      callback?.call(title, body, payload);
    }
  }

  Future<dynamic> _selectNotification(String? payload) async {
    if (payload != null) {
      final id = int.parse(payload);
      if (this._selectCallbackTable.containsKey(id)) {
        final callback = this._selectCallbackTable[id];
        callback?.call();
      }
    }
  }
}
