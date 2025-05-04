// ignore_for_file: unused_import

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:game_critix/Pages/RegisterPage.dart';
import 'package:game_critix/Pages/SplashScreen.dart';
import 'package:game_critix/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  //Supabase App Initialization
  await Supabase.initialize(
      url: 'https://wtbkxydkwclxsmvnwocr.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Ind0Ymt4eWRrd2NseHNtdm53b2NyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDYyODQ5NjMsImV4cCI6MjA2MTg2MDk2M30.bV3HBSdcTOU6Purkv2XSRrvwpm0w70htwDnynTBM-NU');

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
