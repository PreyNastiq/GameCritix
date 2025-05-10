import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:game_critix/Pages/SplashScreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  //Supabase App Initialization
  await dotenv.load(fileName: ".env");
  
  Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

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
