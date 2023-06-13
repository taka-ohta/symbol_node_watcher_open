abstract class NotificationRepository {
  Future<void> initialize();
  Future<void> notify({
    required int id,
    required String title,
    required String body,
  });
  void registerCallback({
    required int id,
    required Function show,
    required Function select,
  });
  void unRegisterCallback({required int id});
}
