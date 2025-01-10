import 'package:timezone/timezone.dart' as tz;

/// Interface for notification time handling
abstract class ITimeZoneService {
  Future<void> initialize();
  Future<tz.TZDateTime> getScheduledDate(DateTime time);
}
