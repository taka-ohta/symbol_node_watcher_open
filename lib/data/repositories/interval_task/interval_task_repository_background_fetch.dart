import 'package:background_fetch/background_fetch.dart';
import 'package:symbol_node_watcher/domain/repositories/interval_task/intarval_task_repository.dart';

class IntervalTaskRepositoryBackgroundFetch extends IntervalTaskRepository {
  static final _headlessCallbackTable = Map<String, Function>();
  final _callbackTable = Map<String, Function>();

  @override
  Future<void> initialize() async {
    await BackgroundFetch.registerHeadlessTask(
        IntervalTaskRepositoryBackgroundFetch._headlessTask);
    await BackgroundFetch.configure(
      BackgroundFetchConfig(
        minimumFetchInterval: 15,
        startOnBoot: true,
        stopOnTerminate: false,
        enableHeadless: true,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresStorageNotLow: false,
        requiresDeviceIdle: false,
        requiredNetworkType: NetworkType.NONE,
      ),
      this._receiveEvent,
      this._receiveTimeoutEvent,
    );
  }

  @override
  registerCallback({required String id, required Function callback}) {
    IntervalTaskRepositoryBackgroundFetch._headlessCallbackTable[id] = callback;
    this._callbackTable[id] = callback;
  }

  @override
  unRegisterCallback({required String id}) {
    IntervalTaskRepositoryBackgroundFetch._headlessCallbackTable.remove(id);
    this._callbackTable.remove(id);
  }

  _receiveEvent(String taskId) async {
    this._callbackTable.forEach((key, value) {
      value.call();
    });
    BackgroundFetch.finish(taskId);
  }

  _receiveTimeoutEvent(String taskId) async {
    BackgroundFetch.finish(taskId);
  }

  static _headlessTask(HeadlessTask task) async {
    IntervalTaskRepositoryBackgroundFetch._headlessCallbackTable
        .forEach((key, value) {
      value.call();
    });
    BackgroundFetch.finish(task.taskId);
  }
}
