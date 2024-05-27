import 'package:agristats/Frontend/Homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerificationComplete extends StatelessWidget{
  const VerificationComplete({super.key});

  @override
  Widget build(BuildContext context){
    final window = Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SafeArea(
            child: CircleAvatar(
              backgroundColor: Color(0xffD9D9D9),
              radius: 120,
              child: Image(
                image: AssetImage("images/like.png"),
                width: 100,
                height: 100,
              ),
            )
          ),
          Column(
            children: [
              const Text(
                'Account Verified',
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: "Times",
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Dear user, your account has been verified successfully, click on continue to proceed to the Home page.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Times",
                    color: Colors.white,

                  ),
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 15,bottom: 15,right: 80,left: 80),
            width: double.infinity,
            height: 75,
            child: ElevatedButton(
                onPressed: (){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Homepage()), (route) => false);

                },
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  backgroundColor: const Color(0xff6B8D01),
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: "Times"
                  ),
                )
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xff1b424e),
      body: window,
    );
  }
}