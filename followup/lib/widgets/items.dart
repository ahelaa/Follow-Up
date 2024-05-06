import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class itemslist extends StatelessWidget {
  itemslist({this.color, this.text, this.text2,this.text3 });
  Color? color;
  String? text;
  String? text2;
  String? text3;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              text!,
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(text2!, style: TextStyle(color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(text3!,
                style: TextStyle(color: Colors.white, fontSize: 18)),
          )
        ],
      ),
    );
  }
}
