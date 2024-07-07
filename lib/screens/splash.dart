import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:test_ui/screens/mapscreen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset('assets/images/Animation - 1720347020039.json'),
          const SizedBox(
              height: 20), // Add space between the animation and text
          const Text(
            'Test UI',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      nextScreen: MapScreen(),
      backgroundColor: Colors.white,
      splashIconSize:
          double.infinity, // Ensure splash screen covers the entire screen
      duration: 2000, // Duration in milliseconds
    );
  }
}
