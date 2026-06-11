import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Feed',
          style: TextStyle(color: Colors.white54, fontSize: 20),
        ),
      ),
    );
  }
}
