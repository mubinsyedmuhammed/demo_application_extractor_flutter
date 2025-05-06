import 'package:get_it/get_it.dart';
import '../services/interfaces/i_background_service.dart';
import '../services/interfaces/i_overlay_service.dart';
import '../services/implementations/background_service_impl.dart';
import '../services/implementations/overlay_service_impl.dart';
import '../services/app_service_facade.dart';

final GetIt locator = GetIt.instance;

void setupServiceLocator() {
  // Register services with their interfaces
  locator.registerLazySingleton<IBackgroundService>(() => BackgroundServiceImpl());
  locator.registerLazySingleton<IOverlayService>(() => OverlayServiceImpl());
  
  // Register facade
  locator.registerLazySingleton(() => AppServiceFacade());
}
