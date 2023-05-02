import 'package:flutter/material.dart';

/// Sebuah `Utility` yang digunakan untuk mengakses warna aplikasi dari Class
/// [AppColorData].
///
/// hanya berfungsi ketika diberi method [AppColor.theme], method tersebut
/// digunakan hanya untuk mengakses data pada [AppColorData].
///
/// Contoh kode :
/// ```dart
/// AppColor.theme(Brightness.light).primary;
/// AppColor.theme(Brightness.dark).secondary;
/// ```
///
/// `Brightness` digunakan untuk mendeteksi apakah tema terang atau gelap, sehingga
/// ketika tema berubah kode hexa dari warna juga berubah.
class AppColor {
  static AppColorData theme(Brightness brightness) {
    return AppColorData(brightness);
  }
}

/// Sebuah [Class] untuk menyimpan `warna` pada aplikasi.
///
/// Field Class ini tidak dapat di akses karena agar warna aplikasi tidak mudah
/// diubah semena-mena.
///
/// Untuk mengaksesnya anda hanya perlu menggunakan Class [AppColor] dan menggunakan
/// method [AppColor.theme] setelah itu masukan [Brightness] pada parameter method,
/// lalu panggil salah satu Field menggunakan method `get` sebagai contoh `.primary`.
///
/// Contoh kode :
/// ```dart
/// AppColor.theme(Brightness.light).primary;
/// AppColor.theme(Brightness.dark).secondary;
/// ```
/// `Brightness` digunakan untuk mendeteksi apakah tema terang atau gelap, sehingga
/// ketika tema berubah kode hexa dari warna juga berubah.
class AppColorData {
  bool _isNotDark = true;

  AppColorData(Brightness brightness) {
    _isNotDark = brightness == Brightness.light ? true : false;
  }

  //* Warna Dasar
  //! Pada saat "Dark Mode"  warna akan di reverse
  final Color _black = const Color(0xFF222831);
  final Color _white = const Color(0xFFFFFBFE);

  //* Warna Aplikasi (Tema terang)
  final Color _primary = const Color(0xFFEEEEEE);
  final Color _secondary = const Color(0xFF7971EA);
  final Color _secondaryContainer = const Color(0xFFDDDBFA);
  final Color _onSecondaryContainer = const Color(0xFF09072C);
  final Color _tertiary = const Color(0xFF393E46);
  final Color _background = const Color(0xFFFFFBFE);
  final Color _onBackground = const Color(0xFF222831);

  //* Warna Aplikasi (Tema gelap)
  final Color _darkPrimary = const Color(0xFFEEEEEE);
  final Color _darkSecondary = const Color(0xFFA39DF1);
  final Color _darkSecondaryContainer = const Color(0xFF121122);
  final Color _darkOnSecondaryContainer = const Color(0xFFD9D7FE);
  final Color _darkTertiary = const Color(0xFF393E46);
  final Color _darkBackground = const Color(0xFF222831);
  final Color _darkOnBackground = const Color(0xFFFFFBFE);

  //* get warna
  Color get black => _isNotDark ? _black : _white;
  Color get white => _isNotDark ? _white : _black;
  Color get primary => _isNotDark ? _primary : _darkPrimary;
  Color get secondary => _isNotDark ? _secondary : _darkSecondary;
  Color get secondaryContainer =>
      _isNotDark ? _secondaryContainer : _darkSecondaryContainer;
  Color get onSecondaryContainer =>
      _isNotDark ? _onSecondaryContainer : _darkOnSecondaryContainer;
  Color get tertiary => _isNotDark ? _tertiary : _darkTertiary;
  Color get background => _isNotDark ? _background : _darkBackground;
  Color get onBackground => _isNotDark ? _onBackground : _darkOnBackground;
}
