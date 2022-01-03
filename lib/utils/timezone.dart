import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart';

class TimeZoneUtils {
  Location _currentLocation;

  Future setCurentLocation() async {
    String timezone = 'Etc/UTC';
    try {
      timezone = await FlutterNativeTimezone.getLocalTimezone();
    } catch (e) {
      print('Could not get the local timezone');
    }
    _currentLocation = getLocation(timezone);
    setLocalLocation(_currentLocation);
    return _currentLocation;
  }
}
