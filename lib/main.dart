import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CIB-summer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'CIB-summer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Make the stream controller a broadcast stream to allow multiple listeners
  StreamController<int> controller = StreamController<int>.broadcast();
  final List<String> options = [
    "Scooter",
    "Apple Watch",
    "Racket",
    "Hard Luck",
    "Try Again",
    "Towel",
    "Premium Kit",
    "Beach Chair"
  ];

  void spinWheel() {
    final random = Random();
    final selected = random.nextInt(options.length);
    controller.add(selected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.title),
      ),
      body: Container(
        // height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Pattern-CIB-summer_page-0004.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: spinWheel,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: FortuneWheel(
                    hapticImpact: HapticImpact.medium,
                    // styleStrategy: StyleStrategy,

                    selected: controller.stream,
                    items: options
                        .map((option) => FortuneItem(child: Text(option)))
                        .toList(),
                  ),
                ),
              ),
              // const SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: spinWheel,
              //   child: const Text('Spin'),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }
}
