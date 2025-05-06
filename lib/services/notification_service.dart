import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'interfaces/i_service.dart';

class NotificationService implements IService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
  bool _isRunning = false;

  @override
  Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    const initSettings = InitializationSettings(android: androidSettings, iOS: iosSettings);
    
    await _notificationsPlugin.initialize(initSettings);
  }

  @override
  Future<void> start() async {
    const androidDetails = AndroidNotificationDetails(
      'background_service_channel',
      'Background Service',
      importance: Importance.high,
    );
    const notificationDetails = NotificationDetails(android: androidDetails);
    
    await _notificationsPlugin.show(
      888,
      'App Running in Background',
      'Tap to return to app',
      notificationDetails,
    );
    _isRunning = true;
  }

  @override
  Future<void> stop() async {
    await _notificationsPlugin.cancel(888);
    _isRunning = false;
  }

  @override
  Future<bool> isRunning() async => _isRunning;
}
