import 'package:dream/shared/services/time_zone_service.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:injectable/injectable.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

/// Time zone handling service
@injectable
class TimeZoneRepository implements ITimeZoneService {
  @override
  Future<void> initialize() async {
    tz_data.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  @override
  Future<tz.TZDateTime> getScheduledDate(DateTime time) async {
    return tz.TZDateTime.from(time, tz.local);
  }
}
