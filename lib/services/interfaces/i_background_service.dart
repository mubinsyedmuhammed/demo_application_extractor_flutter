abstract class IBackgroundService {
  Future<void> initialize();
  Future<void> start();
  Future<void> stop();
  Future<bool> isRunning();
}
