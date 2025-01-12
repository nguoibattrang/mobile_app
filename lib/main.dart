
import 'package:flutter/material.dart';
import 'package:vcs_hackathon/home_screen.dart';

void main() {
  runApp(const Example());
}

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat UI Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xffEE5366),
        colorScheme:
        ColorScheme.fromSwatch(accentColor: const Color(0xffEE5366)),
      ),
      home: const HomeScreen(),
    );
  }
}