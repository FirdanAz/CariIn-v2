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
  final Color _primary = const Color(0xFF3A58B7);
  final Color _onPrimary = const Color(0xFFFFFFFF);
  final Color _primaryContainer = const Color(0xFFDCE1FF);
  final Color _onPrimaryContainer = const Color(0xFF00164F);
  final Color _secondary = const Color(0xFF595D72);
  final Color _onSecondary = const Color(0xFFFFFFFF);
  final Color _secondaryContainer = const Color(0xFFDEE1F9);
  final Color _onSecondaryContainer = const Color(0xFF161B2C);
  final Color _tertiary = const Color(0xFF75546F);
  final Color _onTertiary = const Color(0xFFFFFFFF);
  final Color _tertiaryContainer = const Color(0xFFFFD7F5);
  final Color _onTertiaryContainer = const Color(0xFFFFD7F5);
  final Color _error = const Color(0xFFBA1A1A);
  final Color _errorContainer = const Color(0xFFFFDAD6);
  final Color _onError = const Color(0xFFFFFFFF);
  final Color _onErrorContainer = const Color(0xFF410002);
  final Color _background = const Color(0xFFFEFBFF);
  final Color _onBackground = const Color(0xFF1B1B1F);
  final Color _outline = const Color(0xFF767680);
  final Color _onInverseSurface = const Color(0xFFF2F0F4);
  final Color _inverseSurface = const Color(0xFF303034);
  final Color _inversePrimary = const Color(0xFFB6C4FF);
  final Color _shadow = const Color(0xFF000000);
  final Color _surfaceTint = const Color(0xFF3A58B7);
  final Color _outlineVariant = const Color(0xFFC6C5D0);
  final Color _scrim = const Color(0xFF000000);
  final Color _surface = const Color(0xFFFBF8FD);
  final Color _surfaceContainer = const Color(0xFFEFEDF1);
  final Color _onSurface = const Color(0xFF1B1B1F);
  final Color _surfaceVariant = const Color(0xFFE2E1EC);
  final Color _onSurfaceVariant = const Color(0xFF45464F);

  //* Warna Aplikasi (Tema gelap)
  final Color _darkPrimary = const Color(0xFFB6C4FF);
  final Color _darkOnPrimary = const Color(0xFF00277E);
  final Color _darkPrimaryContainer = const Color(0xFF1D3F9E);
  final Color _darkOnPrimaryContainer = const Color(0xFFDCE1FF);
  final Color _darkSecondary = const Color(0xFFC2C5DD);
  final Color _darkOnSecondary = const Color(0xFF2B3042);
  final Color _darkSecondaryContainer = const Color(0xFF424659);
  final Color _darkOnSecondaryContainer = const Color(0xFFDEE1F9);
  final Color _darkTertiary = const Color(0xFFE3BADA);
  final Color _darkOnTertiary = const Color(0xFF432740);
  final Color _darkTertiaryContainer = const Color(0xFF5B3D57);
  final Color _darkOnTertiaryContainer = const Color(0xFFFFD7F5);
  final Color _darkError = const Color(0xFFFFB4AB);
  final Color _darkErrorContainer = const Color(0xFF93000A);
  final Color _darkOnError = const Color(0xFF690005);
  final Color _darkOnErrorContainer = const Color(0xFFFFDAD6);
  final Color _darkBackground = const Color(0xFF1B1B1F);
  final Color _darkOnBackground = const Color(0xFFE4E1E6);
  final Color _darkOutline = const Color(0xFF90909A);
  final Color _darkOnInverseSurface = const Color(0xFF1B1B1F);
  final Color _darkInverseSurface = const Color(0xFFE4E1E6);
  final Color _darkInversePrimary = const Color(0xFF3A58B7);
  final Color _darkShadow = const Color(0xFF000000);
  final Color _darkSurfaceTint = const Color(0xFFB6C4FF);
  final Color _darkOutlineVariant = const Color(0xFF45464F);
  final Color _darkScrim = const Color(0xFF000000);
  final Color _darkSurface = const Color(0xFF131316);
  final Color _darkOnSurface = const Color(0xFFC8C6CA);
  final Color _darkSurfaceVariant = const Color(0xFF45464F);
  final Color _darkOnSurfaceVariant = const Color(0xFFC6C5D0);

  //* get warna
  Color get black => _isNotDark ? _black : _white;
  Color get white => _isNotDark ? _white : _black;
  Color get primary => _isNotDark ? _primary : _darkPrimary;
  Color get onPrimary => _isNotDark ? _onPrimary : _darkOnPrimary;
  Color get primaryContainer => _isNotDark ? _primaryContainer : _darkPrimaryContainer;
  Color get onPrimaryContainer => _isNotDark ? _onPrimaryContainer : _darkOnPrimaryContainer;
  Color get secondary => _isNotDark ? _secondary : _darkSecondary;
  Color get onSecondary => _isNotDark ? _onSecondary : _darkOnSecondary;
  Color get secondaryContainer =>
      _isNotDark ? _secondaryContainer : _darkSecondaryContainer;
  Color get onSecondaryContainer =>
      _isNotDark ? _onSecondaryContainer : _darkOnSecondaryContainer;
  Color get tertiary => _isNotDark ? _tertiary : _darkTertiary;
  Color get onTertiary => _isNotDark ? _onTertiary : _darkOnTertiary;
  Color get tertiaryContainer => _isNotDark ? _tertiaryContainer : _darkTertiaryContainer;
  Color get onTertiaryContainer => _isNotDark ? _onTertiaryContainer : _darkOnTertiaryContainer;
  Color get error => _isNotDark ? _error : _darkError;
  Color get errorContainer => _isNotDark ? _errorContainer : _darkErrorContainer;
  Color get onError => _isNotDark ? _onError : _darkOnError;
  Color get onErrorContainer => _isNotDark ? _onErrorContainer : _darkOnErrorContainer;
  Color get background => _isNotDark ? _background : _darkBackground;
  Color get onBackground => _isNotDark ? _onBackground : _darkOnBackground;
  Color get outline => _isNotDark ? _outline : _darkOutline;
  Color get onInverseSurface => _isNotDark ? _onInverseSurface : _darkOnInverseSurface;
  Color get inverseSurface => _isNotDark ? _inverseSurface : _darkInverseSurface;
  Color get inversePrimary => _isNotDark ? _inversePrimary : _darkInversePrimary;
  Color get shadow => _isNotDark ? _shadow : _darkShadow;
  Color get surfaceTint => _isNotDark ? _surfaceTint : _darkSurfaceTint;
  Color get outlineVariant => _isNotDark ? _outlineVariant : _darkOutlineVariant;
  Color get scrim => _isNotDark ? _scrim : _darkScrim;
  Color get surface => _isNotDark ? _surface : _darkSurface;
  Color get surfaceContainer => _isNotDark ? _surfaceContainer : _darkSurface;
  Color get onSurface => _isNotDark ? _onSurface : _darkOnSurface;
  Color get surfaceVariant => _isNotDark ? _surfaceVariant : _darkSurfaceVariant;
  Color get onSurfaceVariant => _isNotDark ? _onSurfaceVariant : _darkOnSurfaceVariant;
}
