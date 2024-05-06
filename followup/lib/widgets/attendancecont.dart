import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:followup/widgets/buttom2.dart';

class attendancecont extends StatelessWidget {
  attendancecont({this.color, this.text1});
  Color? color;
  String? text1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 25, top: 16, bottom: 16, right: 16),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
      width: 350,
      height: 110,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'attendance',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(12),
                child: Icon(
                  Icons.person_3,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              //di hatwady llgadwal bta3 el behavior
            },
            child: Buttom2(
              text: 'open',
              color: Color(0xff235391),
            ),
          )
        ],
      ),
    );
  }
}