import 'package:cariin_v2/common/app_theme.dart';
import 'package:cariin_v2/common/responsive.dart';
import 'package:cariin_v2/firebase_options.dart';
import 'package:cariin_v2/ui/karyawan/splash_screen/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'common/push_notification_config.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  runApp(const MyApp());
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await PushNotificationConfig().requestPermission();
  await PushNotificationConfig().androidNotificationChanel();
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
