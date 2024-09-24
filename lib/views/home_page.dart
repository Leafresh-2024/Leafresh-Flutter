import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});  // const 키워드 추가

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Text('Welcome to Home Page'),
      ),
    );
  }
}
