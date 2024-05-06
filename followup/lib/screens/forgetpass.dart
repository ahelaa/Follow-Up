import 'package:followup/screens/verify.dart';
import 'package:followup/widgets/buttom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class forgetpass extends StatelessWidget {
  const forgetpass({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Positioned.fill(
        //5
        child: Image(
          image: AssetImage('assets/images/backgroundd.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      AppBar(
        title: Text(
          'Forget Your Password',
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
      ),
      Center(
        child: Column(
          children: [
            SizedBox(
              height: 150,
            ),
            Text(
              'choose your method to verify',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(
              height: 150,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (Context) {
                  return Verifypage();
                }));
              },
              //el button eli haidous 3alih ywady 3ala el verify
              child: CustomButtom(text: ' email'),
            ),
            SizedBox(
              height: 30,
            ),
            //
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (Context) {
                  return Verifypage();
                }));
              },
              //el button eli haidous 3alih ywady 3ala el verify
              child: CustomButtom(text: ' phone message '),
            )
          ],
        ),
      )
    ]);
  }
}
