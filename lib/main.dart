// ignore_for_file: unused_import

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:game_critix/Pages/RegisterPage.dart';
import 'package:game_critix/Pages/SplashScreen.dart';
import 'package:game_critix/Test.dart';
import 'package:game_critix/firebase_options.dart';

void main() async {
  //Firebase App Initialization
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //High Refresh Rate Optimization
  WidgetsFlutterBinding.ensureInitialized();
  await setHighRefreshRate();

  runApp(const MyApp());
}

Future<void> setHighRefreshRate() async {
  final List<DisplayMode> modes = await FlutterDisplayMode.supported;
  final DisplayMode activeMode = await FlutterDisplayMode.active;

  DisplayMode newMode = activeMode;
  for (final DisplayMode mode in modes) {
    if (mode.height == newMode.height &&
        mode.width == newMode.width &&
        mode.refreshRate > newMode.refreshRate) {
      newMode = mode;
    }
  }

  await FlutterDisplayMode.setPreferredMode(newMode);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
