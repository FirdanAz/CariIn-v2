import 'package:cariin_v2/common/app_theme.dart';
import 'package:cariin_v2/common/responsive.dart';
import 'package:cariin_v2/ui/karyawan/splash_screen/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Responsive.init(buildContext: context, size: const Size(360, 800));
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: AppTheme.getLightMode(context),
      darkTheme: AppTheme.getDarkMode(context),
      home: const SplashScren(),
    );
  }
}
