import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static const String _serviceStateKey = 'isServiceRunning';
  
  static Future<bool> getServiceState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_serviceStateKey) ?? false;
  }
  
  static Future<void> saveServiceState(bool isRunning) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_serviceStateKey, isRunning);
  }
}
