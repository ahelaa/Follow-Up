import 'package:flutter/material.dart';

class homeitems extends StatelessWidget {
  homeitems({this.name, this.color});
  final String? name;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Text(name!),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [color!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(15)),
    );
  }
}






