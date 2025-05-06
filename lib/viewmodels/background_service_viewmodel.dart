import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../models/app_state_model.dart';
import '../services/app_service_facade.dart';
import '../utils/preferences_helper.dart';

class BackgroundServiceViewModel extends ChangeNotifier {
  final _serviceFacade = GetIt.I<AppServiceFacade>();
  AppStateModel _appState = AppStateModel();
  
  AppStateModel get appState => _appState;

  Future<void> initializeService() async {
    await _serviceFacade.initialize();
    await loadSavedState();
  }

  Future<void> startBackgroundService() async {
    await _serviceFacade.startAllServices();
    await _updateState(true);
  }

  Future<void> stopBackgroundService() async {
    await _serviceFacade.stopAllServices();
    await _updateState(false);
  }

  Future<void> _updateState(bool isRunning) async {
    _appState = _appState.copyWith(isBackgroundServiceRunning: isRunning);
    notifyListeners();
  }

  Future<void> loadSavedState() async {
    final isRunning = await PreferencesHelper.getServiceState();
    if (isRunning) {
      await startBackgroundService();
    }
  }
}
