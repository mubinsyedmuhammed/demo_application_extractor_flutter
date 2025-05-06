import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:system_alert_window/system_alert_window.dart';


class OverlayService {
  static final OverlayService _instance = OverlayService._internal();
  factory OverlayService() => _instance;
  OverlayService._internal();

  Future<bool> requestPermissions() async {
    try {
      // Request SYSTEM_ALERT_WINDOW permission
      final res = await SystemAlertWindow.requestPermissions(
        prefMode: SystemWindowPrefMode.OVERLAY
      );
      return res ?? false;
    } catch (e) {
      debugPrint('Error requesting permissions: $e');
      return false;
    }
  }

  Future<void> show() async {
    try {
      final hasPermission = await requestPermissions();
      if (!hasPermission) {
        throw PlatformException(
          code: 'PERMISSION_DENIED',
          message: 'Overlay permission not granted'
        );
      }

      // Cancel any existing listeners to prevent memory leaks
      // await SystemAlertWindow.removeListener();
      
      SystemAlertWindow.disposeOverlayListener();

      await SystemAlertWindow.showSystemWindow(
        height: 200,  // Fixed height value
        width: null,  // Will use MATCH_PARENT
        gravity: SystemWindowGravity.TOP,
        notificationTitle: "App is running",
        notificationBody: "Tap to return to the app",
        prefMode: SystemWindowPrefMode.OVERLAY,
        layoutParamFlags: [
          SystemWindowFlags.FLAG_NOT_TOUCH_MODAL,
          SystemWindowFlags.FLAG_NOT_FOCUSABLE
        ]
      );
    } catch (e) {
      debugPrint('Error showing overlay: $e');
      rethrow;
    }
  }

  Future<void> hide() async {
    try {
      await SystemAlertWindow.closeSystemWindow();
    } catch (e) {
      debugPrint('Error hiding overlay: $e');
      rethrow;
    }
  }
}
