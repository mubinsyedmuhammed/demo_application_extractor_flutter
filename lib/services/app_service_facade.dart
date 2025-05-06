import 'package:get_it/get_it.dart';
import 'interfaces/i_background_service.dart';
import 'interfaces/i_overlay_service.dart';
import '../utils/preferences_helper.dart';

class AppServiceFacade {
  final IBackgroundService _backgroundService;
  final IOverlayService _overlayService;

  AppServiceFacade({
    IBackgroundService? backgroundService,
    IOverlayService? overlayService,
  }) : 
    _backgroundService = backgroundService ?? GetIt.I<IBackgroundService>(),
    _overlayService = overlayService ?? GetIt.I<IOverlayService>();

  Future<void> initialize() async {
    await _backgroundService.initialize();
  }

  Future<void> startAllServices() async {
    await Future.wait([
      _backgroundService.start(),
      _overlayService.show(),
    ]);
    await PreferencesHelper.saveServiceState(true);
  }

  Future<void> stopAllServices() async {
    await Future.wait([
      _backgroundService.stop(),
      _overlayService.hide(),
    ]);
    await PreferencesHelper.saveServiceState(false);
  }

  Future<bool> isRunning() async {
    return await _backgroundService.isRunning();
  }
}
