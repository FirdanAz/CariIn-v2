class AppAssets {
  static String companyIcon = AppAssetsData().companyIcon;
  static String warningIcon = AppAssetsData().warningIcon;
  static String filterIcon = AppAssetsData().filterIcon;
  static String firdanImg = AppAssetsData().firdanImg;
  static String appsLogo = AppAssetsData().appsLogo;
}

class AppAssetsData {
  final _companyIcon = "assets/images/company.svg";
  final _warningIcon = "assets/images/warning.svg";
  final _filterIcon = "assets/images/filter.svg";
  final _firdanImg = "assets/images/firdan.jpeg";
  final _appsLogo = "assets/images/apps_logo.svg";

  String get companyIcon => _companyIcon;
  String get warningIcon => _warningIcon;
  String get filterIcon => _filterIcon;
  String get firdanImg => _firdanImg;
  String get appsLogo => _appsLogo;
}
