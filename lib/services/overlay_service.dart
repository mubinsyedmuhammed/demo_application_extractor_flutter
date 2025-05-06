import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:system_alert_window/system_alert_window.dart';
import 'interfaces/i_overlay_service.dart';

class OverlayService implements IOverlayService {
  static final OverlayService _instance = OverlayService._internal();
  factory OverlayService() => _instance;
  OverlayService._internal();

  @override
  Future<bool> requestPermissions() async {
    try {
      return await SystemAlertWindow.requestPermissions(prefMode: SystemWindowPrefMode.OVERLAY) ?? false;
    } catch (e) {
      debugPrint('Error requesting permissions: $e');
      return false;
    }
  }

  @override
  Future<void> show() async {
    try {
      final hasPermission = await requestPermissions();
      if (!hasPermission) {
        throw PlatformException(
          code: 'PERMISSION_DENIED',
          message: 'Overlay permission not granted',
        );
      }

      SystemAlertWindow.disposeOverlayListener();

      await SystemAlertWindow.showSystemWindow(
        height: 60,
        width: 600,
        gravity: SystemWindowGravity.TOP,
        notificationTitle: 'Overlay Title',
        notificationBody: 'Overlay Body',
      );
    } catch (e) {
      debugPrint('Error showing overlay: $e');
      rethrow;
    }
  }

  @override
  Future<void> hide() async {
    try {
      await SystemAlertWindow.closeSystemWindow();
    } catch (e) {
      debugPrint('Error hiding overlay: $e');
      rethrow;
    }
  }
}
