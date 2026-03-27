import 'package:flutter/material.dart';

/// Berisi konstanta-konstanta yang digunakan di aplikasi
class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Dashboard Mahasiswa D4TI';
  static const String appVersion = '1.0.0';

  // Keys
  static const String userPrefsKey = 'user_prefs';

  // Spacing
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;

  // Border Radius
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;

  // Gradients (Materi 6) - Diubah menjadi List dari List Color
  static const List<List<Color>> dashboardGradients = [
    [Color(0xFF2196F3), Color(0xFF64B5F6)], // Blue Gradient
    [Color(0xFF4CAF50), Color(0xFF81C784)], // Green Gradient
    [Color(0xFFFF9800), Color(0xFFFFB74D)], // Orange Gradient
    [Color(0xFFE91E63), Color(0xFFF06292)], // Pink Gradient
  ];
}
