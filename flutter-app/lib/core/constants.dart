import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'Unspool';
  static const int maxScrollsFreeTier = 250;
  static const Duration cooldownDuration = Duration(minutes: 15);
  
  static const List<String> targetPackages = [
    'com.zhiliaoapp.musically', // TikTok
    'com.instagram.android',    // Instagram
    'com.google.android.youtube', // YouTube
    'com.snapchat.android',     // Snapchat
  ];
}
