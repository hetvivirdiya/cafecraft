import 'dart:async';

import 'package:cafecraft/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {

    Timer(const Duration(seconds: 3), ()
    => Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginScreen())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5E6),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/cafe_craft.png',width: 250,height: 250),

            const SizedBox(height: 45),
            const SizedBox( width: 30, height: 30,
              child: CircularProgressIndicator(
                strokeWidth: 3, valueColor: AlwaysStoppedAnimation<Color>( Color(0xFF7A3E1D), ), ), ),
          ],
        ),
      ),
    );
  }
}
