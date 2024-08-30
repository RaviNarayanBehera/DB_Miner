import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacementNamed('/home');
    });
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 250,
          ),
          const Center(
            child: CircleAvatar(
              radius: 100,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/images/logo1.png'),

            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Quotes App',
            style: TextStyle(
                color: Colors.red[400], fontSize: 36, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
