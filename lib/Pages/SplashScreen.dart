// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game_critix/Pages/Auth/AuthPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _titleOpacity = 0.0;
  double _subtitleOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      setState(() {
        _titleOpacity = 1.0;
      });
    });
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _subtitleOpacity = 1.0;
      });
    });
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AuthPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Padding(
              padding: const EdgeInsets.all(100.0),
              child: Image.asset(
                'lib/Images/logo.png',
                height: 300,
              ),
            ),

            //title
            AnimatedOpacity(
              opacity: _titleOpacity,
              duration: const Duration(seconds: 1),
              child: const Text(
                'G A M E   R E V I E W   R E P E A T',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color.fromARGB(255, 0, 255, 0) ,
                ),
              ),
            ),

            //subtitle
            AnimatedOpacity(
              opacity: _subtitleOpacity,
              duration: const Duration(seconds: 1),
              child: const Text(
                'Get the latest reviews of your favorite games',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  height: 20,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
