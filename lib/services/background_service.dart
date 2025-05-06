import 'package:flutter_background_service/flutter_background_service.dart';
import '../utils/service_helpers.dart';

class BackgroundService {
  final _service = FlutterBackgroundService();

  Future<void> initialize() async {
    await _service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: ServiceHelpers.onStart,
        autoStart: false,
        isForegroundMode: true,
        notificationChannelId: 'background_service_channel',
        initialNotificationTitle: 'App Running in Background',
        initialNotificationContent: 'Tap to return to app',
        foregroundServiceNotificationId: 888,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: false,
        onForeground: ServiceHelpers.onStart,
        onBackground: ServiceHelpers.onIosBackground,
      ),
    );
  }

  Future<void> start() => _service.startService();
  Future<void> stop() => _service.stopService();
  Future<bool> isRunning() => _service.isRunning();
}
