import 'package:followup/widgets/searchicon.dart';
import 'package:flutter/material.dart';

class appbar extends StatelessWidget {
  const appbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'forget my password',
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
        searchicon()
      ],
    );
  }
}
