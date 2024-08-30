import 'package:db_miner/view/detail_screen.dart';
import 'package:db_miner/view/home_screen.dart';
import 'package:db_miner/view/liked_screen.dart';
import 'package:db_miner/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/like', page: () => const LikedQuotesScreen()),
        GetPage(name: '/detail', page: () => const DetailScreen()),
      ],
    );
  }
}
