import 'dart:async';

import 'package:agristats/Backend/FirebaseBackend.dart';
import 'package:agristats/First%20Time%20user/VerificationComplete.dart';
import 'package:agristats/Frontend/Homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../Common/Components.dart';

class VerifyEmail extends StatefulWidget {
  final String email;

  const VerifyEmail({super.key, required this.email});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> with WidgetsBindingObserver{
  bool isVerified = false;

  void showErrorObj(Object){
    showDialog(context: context, builder: (context) => DialogEr(infoType: "Error", info: Object.toString()));
    Navigator.pop(context);

  }

  void checkIfVerifed()async{
    Timer.periodic(const Duration(seconds: 3),(val)async{
      isVerified = await FirebaseBackend.checkIfEmailIsVerified().catchError(showErrorObj);

      if(isVerified){
        if(context.mounted){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context) => const VerificationComplete()), (route) => false);
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    checkIfVerifed();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    final window =  Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xff1b424e),
      child: Column(
        children: [
          const SizedBox(height: 50,),
          const SafeArea(
              child: Text(
                "Verify your Email",
                style: TextStyle(
                    fontFamily: "Times",
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              )
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              "A verification message has been sent to ${widget.email}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontFamily: "Times",
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),
          ),
          const SizedBox(height: 20,),
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(0),
              child: const Text(
                "Resend the verification message",
                style: TextStyle(
                    fontFamily: "Times",
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff239B56)
                ),
              ),
            ),
          ),
          const SizedBox(height: 20,),
          LoadingAnimationWidget.threeArchedCircle(
              color: Colors.white,
              size: 30
          )
        ],
      ),
    );

    return Scaffold(
      body: window,
    );
  }
}