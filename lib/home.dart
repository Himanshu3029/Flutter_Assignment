import 'package:flutter/material.dart';
import 'package:project1/overview.dart';
import 'package:project1/performance.dart';

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
