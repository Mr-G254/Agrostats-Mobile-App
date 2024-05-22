import 'dart:ui';
import 'package:agristats/Frontend/Components.dart';
import 'package:agristats/First%20Time%20user/Register.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final email = TextEditingController();
  final password = TextEditingController();
  final phonenumber = TextEditingController();

  bool _isChecked = false;
  bool _isHidden = true;
  bool _showError = false;


  @override
  void dispose() {
    // TODO: implement dispose
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            hideText: _isHidden),
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
              onChanged: (bool? val) {
                if (val != null) {
                  setState(() {
                    _isChecked = val;
                    _isHidden = !val;
                  });
                }
              },
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: const Color(0xff374804),
            )
        ),
        Container(
          padding: const EdgeInsets.only(
              top: 15, bottom: 15, right: 80, left: 80),
          width: double.infinity,
          height: 75,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              elevation: 10,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              backgroundColor: const Color(0xff374804),
            ),
            child: const Text(
              "Login",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: "Times"
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(right: 30,left: 30,top: 10,bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(child: Divider(thickness: 1,height: 40,color: Colors.white,)),
              Container(
                padding: const EdgeInsets.only(right: 15,left: 15),
                child: const Text(
                  "Or",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontFamily: "Times"
                  ),
                ),
              ),
              const Expanded(child: Divider(thickness: 1,height: 40,color: Colors.white,))
            ],
          ),
        ),
        PhoneInput(label: "PHONE NUMBER",
            editor: phonenumber,
            type: TextInputType.phone,
            action: TextInputAction.done),
        Container(
          padding: const EdgeInsets.only(top: 10,bottom: 15,right: 80,left: 80),
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
              "Use phone number",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontFamily: "Times"
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () =>
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Register())
              ),
          child: Container(
            padding: const EdgeInsets.only(bottom: 10),
            width: double.infinity,
            alignment: Alignment.center,
            child: const Text(
              "Don't have an account? Register",
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