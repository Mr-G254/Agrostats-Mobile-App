import 'dart:async';

import 'package:agristats/Backend/FirebaseBackend.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../Common/Components.dart';

class ForgotPassword extends StatefulWidget{
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword>{
  final email = TextEditingController();
  bool loading = false;
  bool error = false;

  void showErrorObj(Object){
    showDialog(context: context, builder: (context) => DialogEr(infoType: "Error", info: Object.toString()));
    setState(() {
      loading = false;
    });
  }

  final loadingAnimation = LoadingAnimationWidget.threeArchedCircle(
      color: Colors.white,
      size: 30
  );

  final resetText = const Text(
    "Reset",
    style: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontFamily: "Times"
    ),
  );

  void reset(){
    if(email.text.isNotEmpty){
        setState(() {
          loading = true;
          error = false;
        });

        FirebaseBackend.passwordReset(email.text, (){}, showErrorObj);


        Timer(const Duration(seconds: 3), () {
          Navigator.of(context).pop();

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Color(0xff255A6B),
            content: Text(
              "Check your email to reset",
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontFamily: "Times"
              ),
            ),
          ));
        });

    }else{
      setState(() {
        error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context){
    final appBar = AppBar(
      backgroundColor: const Color(0xff1b424e),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.white,
        ),
        onPressed: (){
          Navigator.of(context).pop();
        },
      ),
    );

    final window = Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xff1b424e),
      child: Column(
        children: [
          const SafeArea(
              child: Text(
                "Forgot Password",
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
            child: const Text(
              "Enter your email where we can send a password reset.",
              style: TextStyle(
                  fontFamily: "Times",
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),
          ),
          const SizedBox(height: 30,),
          Input(label: "EMAIL",
              editor: email,
              type: TextInputType.emailAddress,
              action: TextInputAction.next,
              errorTxt: "Enter your email to proceed",
              showError: error,
          ),
          Container(
            padding: const EdgeInsets.only(top: 15,bottom: 15,right: 80,left: 80),
            width: double.infinity,
            height: 75,
            child: ElevatedButton(
                onPressed: ()async{
                  reset();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  backgroundColor: const Color(0xff6B8D01),
                ),
                child: loading? loadingAnimation : resetText
            ),
          ),
        ],
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: window,
    );
  }
}
