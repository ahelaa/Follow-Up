import 'package:followup/widgets/buttom.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class Verifypage extends StatelessWidget {
  const Verifypage({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
        width: 56,
        height: 60,
        textStyle: const TextStyle(fontSize: 22, color: Colors.black),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 215, 214, 214),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.transparent)));
    return Scaffold(
      backgroundColor: Color(0xff235391),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Container(
          margin: EdgeInsets.only(top: 40),
          width: double.infinity,
          child: Column(
            children: [
              Text(
                'Enter Your Verification',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'enter the code that we sent ',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 70,
              ),
              Pinput(
                length: 4,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(
                        color: const Color.fromARGB(255, 190, 189, 189)),
                  ),
                ),
                // onCompleted: (Pin) => debugPrint(pin),
              ),
              SizedBox(
                height: 80,
              ),
              Text(
                'Resend',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                height: 50,
              ),
              CustomButtom(
                text: 'VERIFY',
                color: Color.fromARGB(255, 18, 18, 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
