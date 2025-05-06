import 'package:flutter/material.dart';
import '../models/app_state_model.dart';
import '../services/background_service.dart';
import '../services/overlay_service.dart';
import '../utils/preferences_helper.dart';

class BackgroundServiceViewModel extends ChangeNotifier {
  final BackgroundService _backgroundService = BackgroundService();
  final OverlayService _overlayService = OverlayService();
  AppStateModel _appState = AppStateModel();
  
  AppStateModel get appState => _appState;

  Future<void> initializeService() async {
    await _backgroundService.initialize();
    await loadSavedState();
  }

  Future<void> startBackgroundService() async {
    await startService();
  }

  Future<void> stopBackgroundService() async {
    await stopService();
  }

  Future<void> startService() async {
    await _backgroundService.start();
    await _overlayService.show();
    await _updateState(true);
  }

  Future<void> stopService() async {
    await _backgroundService.stop();
    await _overlayService.hide();
    await _updateState(false);
  }

  Future<void> _updateState(bool isRunning) async {
    _appState = _appState.copyWith(isBackgroundServiceRunning: isRunning);
    await PreferencesHelper.saveServiceState(isRunning);
    notifyListeners();
  }

  Future<void> loadSavedState() async {
    final isRunning = await PreferencesHelper.getServiceState();
    if (isRunning) {
      await startService();
    }
  }

  @override
  void dispose() {
    stopService();
    super.dispose();
  }
}
