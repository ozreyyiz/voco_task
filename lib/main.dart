import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voco_task/controller/login_controller.dart';
import 'package:voco_task/view/login_page.dart';
import 'package:voco_task/view/participants_page.dart';
import 'package:voco_task/view/splash_screen.dart';


void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home:const SplashScreen(),
    );
  }
}
