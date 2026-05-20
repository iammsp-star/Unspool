import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

/// A service designed to communicate with the native Android AccessibilityService.
/// This acts as a background hook to track touches and scrolls across target social media apps.
class AndroidAccessibilityService {
  static const MethodChannel _channel = MethodChannel('com.unspool.app/accessibility');

  /// Checks if the Accessibility Service is enabled in Android settings.
  Future<bool> isServiceEnabled() async {
    if (!PlatformDispatcher.instance.defaultRouteName.contains('android')) {
      return false; // Not on Android
    }
    
    try {
      final bool result = await _channel.invokeMethod('isServiceEnabled');
      return result;
    } on PlatformException catch (e) {
      debugPrint("Failed to check accessibility service status: '${e.message}'.");
      return false;
    }
  }

  /// Requests the OS to open the Accessibility Settings page for the user.
  Future<void> requestServicePermission() async {
    try {
      await _channel.invokeMethod('requestPermission');
    } on PlatformException catch (e) {
      debugPrint("Failed to request permission: '${e.message}'.");
    }
  }
}
