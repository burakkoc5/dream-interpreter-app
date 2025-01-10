abstract class INotificationService {
  Future<void> initialize();
  Future<void> scheduleDreamReminder({required DateTime time});
  Future<void> cancelAllReminders();
}
