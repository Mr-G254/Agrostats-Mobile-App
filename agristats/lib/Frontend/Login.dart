import 'dart:ui';
import 'package:agristats/Backend/FirebaseBackend.dart';
import 'package:agristats/Common/Components.dart';
import 'package:agristats/First%20Time%20user/Register.dart';
import 'package:agristats/Frontend/ForgotPassword.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../First Time user/VerifyPhone.dart';
import 'Homepage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final email = TextEditingController();
  final password = TextEditingController();
  final phonenumber = TextEditingController();
  bool loginLoading = false;
  bool phoneLoading = false;

  bool _isChecked = false;
  bool _isHidden = true;

  String completePhoneNumber = "";
  void showErrorObj(Object){
    showDialog(context: context, builder: (context) => DialogEr(infoType: "Error", info: Object.toString()));
    setState(() {
      phoneLoading = false;
      loginLoading = false;
    });
  }

  void getnumber(String val){
    completePhoneNumber = val;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    email.dispose();
    password.dispose();
    super.dispose();
  }

  final loadingAnimation = LoadingAnimationWidget.threeArchedCircle(
      color: Colors.white,
      size: 30
  );

  final loginText = const Text(
    "Login",
    style: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontFamily: "Times"
    ),
  );

  final phoneText = const Text(
    "Use phone number",
    style: TextStyle(
        fontSize: 15,
        color: Colors.white,
        fontFamily: "Times"
    ),
  );
  
  void goToHomePage(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Homepage()), (route) => false);
  }


  void loginWithEmail()async{
    setState(() {
      loginLoading = true;
    });

    final emailIsValid = EmailValidator.validate(email.text);
    if(emailIsValid){
      await FirebaseBackend.signInWithEmailAndPassword(email.text, password.text,goToHomePage,showErrorObj);
    }else{
      showErrorObj("Email is invalid");
    }
    
  }

  void verifyPhonenumber(String verId){
    Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyPhone(name: "",phoneNumber: completePhoneNumber,verificationId: verId,)));
  }

  void loginWithPhone()async{
    if(phonenumber.text.isNotEmpty){
      setState(() {
        phoneLoading = true;
      });

      if(completePhoneNumber.startsWith("+254")){
        completePhoneNumber = completePhoneNumber.substring(0,4) + completePhoneNumber.substring(5,completePhoneNumber.length);
      }

      FirebaseBackend.verifyPhoneNumber("",completePhoneNumber,verifyPhonenumber,showErrorObj);



    }else{
      showErrorObj("Enter your phone number");
    }
  }

  void changeVisibility(){
    setState(() {
      _isHidden = !_isHidden;
    });
  }


  @override
  Widget build(BuildContext context) {
    var view = IconButton(
        onPressed: () => changeVisibility(),
        icon: _isHidden ? const Icon(Icons.visibility_outlined,color: Colors.white,) : const Icon(Icons.visibility_off_outlined,color: Colors.white,)
    );

    final column = Column(
      children: [
        const SafeArea(
            child: Text(
              "Agrostats",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Times",
                  fontSize: 35,
                  fontWeight: FontWeight.bold
              ),
            )
        ),
        Input(label: "EMAIL",
            editor: email,
            type: TextInputType.emailAddress,
            action: TextInputAction.next),
        Input(label: "PASSWORD",
            editor: password,
            type: TextInputType.visiblePassword,
            action: TextInputAction.done,
            hideText: _isHidden,
            icon: view,
        ),
        GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ForgotPassword()));
          },
          child: Container(
            alignment: Alignment.topRight,
            padding: const EdgeInsets.only(right: 30),
            height: 40,
            // alignment: Alignment.centerLeft,
            child: const Text(
              "Forgot password?",
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontFamily: "Times"
              ),
            ),
          ),
        ),

        Container(
          padding: const EdgeInsets.only(
              top: 15, bottom: 15, right: 80, left: 80),
          width: double.infinity,
          height: 75,
          child: ElevatedButton(
            onPressed: () {
              loginWithEmail();
            },
            style: ElevatedButton.styleFrom(
              elevation: 10,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              backgroundColor: const Color(0xff374804),
            ),
            child: loginLoading? loadingAnimation : loginText
          ),
        ),
      //   Container(
      //     padding: const EdgeInsets.only(right: 30,left: 30,top: 10,bottom: 10),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         const Expanded(child: Divider(thickness: 1,height: 40,color: Colors.white,)),
      //         Container(
      //           padding: const EdgeInsets.only(right: 15,left: 15),
      //           child: const Text(
      //             "Or",
      //             style: TextStyle(
      //               fontSize: 20,
      //               color: Colors.white,
      //               fontFamily: "Times"
      //             ),
      //           ),
      //         ),
      //         const Expanded(child: Divider(thickness: 1,height: 40,color: Colors.white,))
      //       ],
      //     ),
      //   ),
      //   PhoneInput(label: "PHONE NUMBER",
      //     editor: phonenumber,
      //     type: TextInputType.phone,
      //     action: TextInputAction.done,
      //     phoneNumber: completePhoneNumber,
      //     callback: getnumber,
      //   ),
      //   Container(
      //     padding: const EdgeInsets.only(top: 10,bottom: 15,right: 80,left: 80),
      //     width: double.infinity,
      //     height: 75,
      //     child: ElevatedButton(
      //       onPressed: (){
      //         loginWithPhone();
      //       },
      //       style: ElevatedButton.styleFrom(
      //         elevation: 10,
      //         shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      //         backgroundColor: const Color(0xff374804),
      //       ),
      //       child: phoneLoading? loadingAnimation : phoneText
      //     ),
      //   ),
      //   GestureDetector(
      //     onTap: () =>
      //         Navigator.pushReplacement(
      //             context,
      //             MaterialPageRoute(builder: (context) => const Register())
      //         ),
      //     child: Container(
      //       padding: const EdgeInsets.only(bottom: 10),
      //       width: double.infinity,
      //       alignment: Alignment.center,
      //       child: const Text(
      //         "Don't have an account? Register",
      //         style: TextStyle(
      //             fontSize: 12,
      //             color: Colors.white,
      //             fontFamily: "Times"
      //         ),
      //       ),
      //     ),
      //   )
      ],

    );

    final window = Container(
        padding: const EdgeInsets.all(0),
        child: Card(
          color: Colors.transparent,
          elevation: 10,
          child: FractionallySizedBox(
            widthFactor: 0.9,
            heightFactor: 0.8,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: SingleChildScrollView(
                  child: column,
                ),
              ),
            ),
          ),
        )
    );


    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("images/bg.png")
              )
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            padding: const EdgeInsets.all(0),
            alignment: Alignment.center,
            child: window,
          ),
        )
      ],
    );
  }
}