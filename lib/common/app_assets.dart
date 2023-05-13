class AppAssets {
  static String companyIcon = AppAssetsData().companyIcon;
  static String warningIcon = AppAssetsData().warningIcon;
  static String filterIcon = AppAssetsData().filterIcon;
  static String firdanImg = AppAssetsData().firdanImg;
}

class AppAssetsData {
  final _companyIcon = "assets/images/company.svg";
  final _warningIcon = "assets/images/warning.svg";
  final _filterIcon = "assets/images/filter.svg";
  final _firdanImg = "assets/images/firdan.jpeg";

  String get companyIcon => _companyIcon;
  String get warningIcon => _warningIcon;
  String get filterIcon => _filterIcon;
  String get firdanImg => _firdanImg;
}
