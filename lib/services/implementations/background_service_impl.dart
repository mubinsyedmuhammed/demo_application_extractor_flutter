import '../interfaces/i_background_service.dart';

class BackgroundServiceImpl implements IBackgroundService {
  @override
  Future<void> initialize() {
    throw UnimplementedError();
  }

  @override
  Future<bool> isRunning() {
    throw UnimplementedError();
  }

  @override
  Future<void> start() {
    throw UnimplementedError();
  }

  @override
  Future<void> stop() {
    throw UnimplementedError();
  }
  // ...existing code from BackgroundService class...
}
