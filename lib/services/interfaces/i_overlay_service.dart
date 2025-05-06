abstract class IOverlayService {
  Future<bool> requestPermissions();
  Future<void> show();
  Future<void> hide();
}
