import 'package:flutter/material.dart';

/// Class untuk kumpulan fungsi responsif
/// untuk menggunakannya harus menjalankan method [Responsive.init]
class Responsive {
  static Size? _designScreenSize;
  static BuildContext? _context;

  /// Inisialisasi layar
  static void init({required BuildContext buildContext, required Size size}) {
    _context = buildContext;
    _designScreenSize = size;
  }

  /// responsif untuk ukuran font
  static double fontSize(double baseFontSize) {
    final screenSize = MediaQuery.of(_context!).size;
    final scaleFactor = screenSize.width / _designScreenSize!.width;
    return baseFontSize * scaleFactor;
  }

  /// Menyesesuaikan dengan lebar Desain UI
  static double byWidth(double baseWidth) {
    final screenSize = MediaQuery.of(_context!).size;
    final scaleFactor = screenSize.width / _designScreenSize!.width;
    return baseWidth * scaleFactor;
  }

  /// Menyesesuaikan dengan tinggi Desain UI
  static double byHeight(double baseHeight) {
    final screenSize = MediaQuery.of(_context!).size;
    final scaleFactor = screenSize.height / _designScreenSize!.height;
    return baseHeight * scaleFactor;
  }
}
