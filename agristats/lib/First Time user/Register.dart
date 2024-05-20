import 'dart:ui';

import 'package:agristats/Components.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register>{
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final confirm = TextEditingController();

  bool _isChecked = true;
  bool _isHidden = true;

  @override
  Widget build(BuildContext context){

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
        Input(label: "NAME", editor: name, type: TextInputType.text,action: TextInputAction.next,hideText: false),
        Input(label: "EMAIL", editor: email, type: TextInputType.emailAddress,action: TextInputAction.next,hideText: false),
        Input(label: "PHONE NO", editor: phone, type: TextInputType.number,action: TextInputAction.next,hideText: false),
        Input(label: "PASSWORD", editor: password, type: TextInputType.visiblePassword,action: TextInputAction.next,hideText: _isHidden),
        Input(label: "CONFIRM", editor: confirm, type: TextInputType.visiblePassword,action: TextInputAction.done,hideText: _isHidden),
        Container(
          padding: const EdgeInsets.only(left: 10),
          height: 40,
          // alignment: Alignment.centerLeft,
          child: CheckboxListTile(
            title: const Text(
              "Show password",
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontFamily: "Times"
              ),
            ),
            value: _isChecked,
            onChanged: (bool? val){
              if(val != null){
                setState(() {
                  _isChecked = val;
                  _isHidden = val;
                });
              }
            },
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: const Color(0xff374804),
          )
        ),
        Container(
          padding: const EdgeInsets.only(top: 15,bottom: 15,right: 80,left: 80),
          width: double.infinity,
          height: 75,
          child: ElevatedButton(
            onPressed: (){},
            style: ElevatedButton.styleFrom(
              elevation: 10,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
              backgroundColor: const Color(0xff374804),
            ),
            child: const Text(
              "Register",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontFamily: "Times"
              ),
            ),
          ),
        ),
        GestureDetector(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
              "Already have an account? Log in",
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontFamily: "Times"
              ),
            ),
          ),
        )
      ],

    );

    final window = Container(
      padding: const EdgeInsets.all(0),
      child: Card(
        color: Colors.transparent,
        elevation: 10,
        child: FractionallySizedBox(
          widthFactor: 0.9,
          heightFactor: 0.85,
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