import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'locator.dart';
import 'pages/splash_page.dart';

const settingsBox = 'settingsBox';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  await Hive.initFlutter();
  await Hive.openBox(settingsBox);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MultiCamp Flutter Haber',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        primaryIconTheme: IconThemeData(color: Colors.white),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashPage(),
    );
  }
}
