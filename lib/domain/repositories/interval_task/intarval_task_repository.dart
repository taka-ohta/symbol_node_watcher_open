typedef void IntervalTaskCallback();

abstract class IntervalTaskRepository {
  Future<void> initialize();
  registerCallback({required String id, required Function callback});
  unRegisterCallback({required String id});
}
