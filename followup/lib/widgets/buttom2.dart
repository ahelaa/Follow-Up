import 'package:flutter/material.dart';
class Buttom2 extends StatelessWidget {
  Buttom2({required this.text, this.color});
  String text;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
      width: 70,
      height: 30,
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}