abstract class IService {
  Future<void> initialize();
  Future<void> start();
  Future<void> stop();
  Future<bool> isRunning();
}
