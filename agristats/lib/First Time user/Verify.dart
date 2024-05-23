import 'package:agristats/Backend/FirebaseBackend.dart';
import 'package:agristats/Common/Components.dart';
import 'package:agristats/Frontend/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sms_autofill/sms_autofill.dart';

class Verify extends StatefulWidget {
  final String verificationType;
  final String email;
  final String phoneNumber;
  final String verificationId;
  const Verify({super.key, required this.verificationType, required this.email, required this.phoneNumber,required this.verificationId});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify>{
  String smsOtp = "";
  bool loading = false;

  final loadingAnimation = LoadingAnimationWidget.threeArchedCircle(
    color: Colors.white,
    size: 30
  );

  final verifyText = const Text(
    "Verify",
    style: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontFamily: "Times"
    ),
  );

  void verify()async{
    if(smsOtp.length == 6){
      try{
        final cred = await FirebaseBackend.confirmPhoneNumberVerified(widget.verificationId, smsOtp);
        await FirebaseBackend.signInUsingCredential(cred);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Homepage()), (route) => false);

      }catch(e){
        Navigator.push(context, DialogRoute(context: context, builder: (context) => DialogInfo(infoType: "Error", info: e.toString())));
      }
    }
    // if(widget.verificationType == "Email"){
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Verify(verificationType: "Phone", email: widget.email, phoneNumber: widget.phoneNumber)));
    // }
  }

  Future<void> unableToVerify(String error)async{
    await Navigator.push(context, DialogRoute(context: context, builder: (context) => DialogInfo(infoType: "Error", info: error)));
    if(context.mounted){
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context){
    final window = Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xff1b424e),
      child: Column(
        children: [
          const SizedBox(height: 50,),
          SafeArea(
            child: Text(
              "Verify your ${widget.verificationType}",
              style: const TextStyle(
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
              "A 6-digit code has been sent to ${widget.verificationType=="Email"? widget.email: widget.phoneNumber}",
              style: const TextStyle(
                  fontFamily: "Times",
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),
          ),
          const SizedBox(height: 50,),
          Container(
            padding: const EdgeInsets.all(0),
            child: VerificationCode(
              underlineWidth: 2,
              cursorColor: Colors.white,
              onCompleted: (value){smsOtp = value;},
              onEditing: (value){},
              keyboardType: TextInputType.visiblePassword,
              textStyle: const TextStyle(fontFamily: "Times",color: Colors.white,fontSize: 30),
              length: 6,
              underlineColor: Colors.white,
            ),
          ),
          const SizedBox(height: 30,),
          Container(
            padding: const EdgeInsets.all(0),
            child: const Text(
              "Resend the code",
              style: TextStyle(
                  fontFamily: "Times",
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff239B56)
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 15,bottom: 15,right: 80,left: 80),
            width: double.infinity,
            height: 75,
            child: ElevatedButton(
              onPressed: ()async{
                setState(() {
                  loading = true;
                });
                verify();

              },
              style: ElevatedButton.styleFrom(
                elevation: 10,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                backgroundColor: const Color(0xff6B8D01),
              ),
              child: loading? loadingAnimation : verifyText
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      body: window,
    );
  }
}