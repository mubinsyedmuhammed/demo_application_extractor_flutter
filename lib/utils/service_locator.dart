import 'package:get_it/get_it.dart';
import '../services/background_service.dart';
import '../services/overlay_service.dart';

final GetIt locator = GetIt.instance;

void setupServiceLocator() {
  locator.registerLazySingleton(() => BackgroundService());
  locator.registerLazySingleton(() => OverlayService());
}
