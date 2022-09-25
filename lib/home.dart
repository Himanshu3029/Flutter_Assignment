// ignore_for_file: import_of_legacy_library_into_null_safe, unnecessary_const

import 'package:flutter/material.dart';
import 'package:project1/overview.dart';
import 'package:project1/performance.dart';

import 'package:splashscreen/splashscreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            Overview(),
            Performance(),
          ],
        ),
      ),
    );
  }
}

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: const HomePage(),
      title: const Text(
        'Project 1',
        style: TextStyle(color: Color.fromARGB(255, 7, 74, 129)),
        textScaleFactor: 3,
      ),
      loadingText: const Text(
        "Assignment",
        style: TextStyle(color: Color.fromARGB(255, 7, 74, 129)),
      ),
      backgroundColor: Colors.white70,
      useLoader: true,
    );
  }
}
