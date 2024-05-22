import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

class Verify extends StatelessWidget{
  final String verificationType;
  final String email;
  final String phoneNumber;
  const Verify({super.key,required this.verificationType,required this.email,required this.phoneNumber});

  @override
  Widget build(BuildContext context){
    final window = Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xff1b424e),
      child: Column(
        children: [
          SafeArea(
            child: Text(
              "Verify your $verificationType",
              style: const TextStyle(
                fontFamily: "Times",
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            )
          ),
          Text(
            "A 6-digit code has been sent to ${verificationType=="Email"? email: phoneNumber}",
            style: const TextStyle(
              fontFamily: "Times",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
          VerificationCode(
            onCompleted: (value){
              if(verificationType == "Email"){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Verify(verificationType: "Phone number", email: email, phoneNumber: phoneNumber)));
              }
            },
            onEditing: (value){},
            keyboardType: TextInputType.number,
            textStyle: const TextStyle(fontFamily: "Times",color: Colors.white,fontSize: 30),
            length: 6,
            underlineColor: Colors.white,
          )
        ],
      ),
    );

    return Scaffold(
      body: window,
    );
  }
}