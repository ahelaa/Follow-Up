import 'package:flutter/material.dart';

class searchicon extends StatelessWidget {
  const searchicon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(color: Colors.white),
      child: Center(child: Icon(Icons.search)),
    );
  }
}
