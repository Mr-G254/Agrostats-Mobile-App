import 'dart:ui';
import 'package:agristats/Backend/FirebaseBackend.dart';
import 'package:agristats/First%20Time%20user/Verify.dart';
import 'package:agristats/Common/Components.dart';
import 'package:agristats/Frontend/Login.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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

  bool _isChecked = false;
  bool _isHidden = true;
  bool _showError = false;

  bool visible = false;
  bool emailShowError = false;

  String completePhoneNumber = "";
  bool loading  = false;

  void _checkIfPasswordsMatch(){
    if(confirm.text.isNotEmpty && password.text.isNotEmpty) {
      setState(() {
        if (confirm.text == password.text) {
          _showError = false;
        } else {
          _showError = true;
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    password.addListener(_checkIfPasswordsMatch);
    confirm.addListener(_checkIfPasswordsMatch);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    name.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    confirm.dispose();
    super.dispose();
  }

  void getnumber(String val){
    completePhoneNumber = val;
  }

  void verifyPhonenumber(String verId){
    Navigator.push(context, MaterialPageRoute(builder: (context) => Verify(verificationType: "Phone", email: email.text, phoneNumber: completePhoneNumber,verificationId: verId,)));
  }

  void showError(String error){
    Navigator.push(context, MaterialPageRoute(builder: (context) => DialogInfo(infoType: "Error", info: error)));
  }

  void startRegistrationProcess(){
    if(completePhoneNumber.startsWith("+254")){
      completePhoneNumber = completePhoneNumber.substring(0,4) + completePhoneNumber.substring(5,completePhoneNumber.length);
    }
    if(name.text.isEmpty || phone.text.isEmpty || password.text.isEmpty || confirm.text.isEmpty){
      setState(() {
        visible = true;
      });
    }else{
      setState(() {
        visible = false;
      });

      if(email.text.isNotEmpty) {
        final emailIsValid = EmailValidator.validate(email.text);

        if (!emailIsValid) {
          setState(() {
            emailShowError = true;
          });
        } else {
          setState(() {
            emailShowError = false;
          });

          // Navigator.push(context, MaterialPageRoute(builder: (context) => Verify(verificationType: "Email", email: email.text, phoneNumber: completePhoneNumber)));
        }


      }else{
        try{
          FirebaseBackend.verifyPhoneNumber(completePhoneNumber, showError, verifyPhonenumber);
        }catch(e){
          showError(e.toString());
        }


      }

      // Navigator.push(context, MaterialPageRoute(builder: (context) => Verify(verificationType: "Phone", email: email.text, phoneNumber: completePhoneNumber)));
    }
  }

  final regText = const Text(
    "Register",
    style: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontFamily: "Times"
    ),
  );

  final loadingAnimation = LoadingAnimationWidget.threeArchedCircle(
      color: Colors.white,
      size: 30
  );

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
        Visibility(
          visible: visible,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: Container(
            color: Colors.transparent,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline_rounded,size: 20,color: Colors.red,),
                SizedBox(width: 10,),
                Text(
                  "Ensure that all field are filled",
                  style: TextStyle(
                      color: Colors.red,
                      fontFamily: "Times",
                      fontSize: 10,
                      fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
        ),
        Input(label: "NAME", editor: name, type: TextInputType.text,action: TextInputAction.next),
        Input(label: "EMAIL(Optional)", editor: email, type: TextInputType.emailAddress,action: TextInputAction.next,errorTxt: "Invalid Email",showError: emailShowError,),
        PhoneInput(label: "PHONE NUMBER", editor: phone, type: TextInputType.phone,action: TextInputAction.next,phoneNumber: completePhoneNumber,callback: getnumber,),
        Input(label: "PASSWORD", editor: password, type: TextInputType.visiblePassword,action: TextInputAction.next,hideText: _isHidden),
        Input(label: "CONFIRM", editor: confirm, type: TextInputType.visiblePassword,action: TextInputAction.done,hideText: _isHidden,errorTxt: "The passwords don't match",showError: _showError,),
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
                  _isHidden = !val;
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
            onPressed: (){
              setState(() {
                loading = true;
              });
              startRegistrationProcess();
            },
            style: ElevatedButton.styleFrom(
              elevation: 10,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
              backgroundColor: const Color(0xff374804),
            ),
            child: loading? loadingAnimation : regText
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Login())
          ),
          child: Container(
            padding: const EdgeInsets.only(bottom: 10),
            width: double.infinity,
            alignment: Alignment.center,
            child: const Text(
              "Already have an account? Log in",
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontFamily: "Times"
              ),
            ),
          ),
        ),

      ],

    );

    final window = Container(
      padding: const EdgeInsets.all(0),
      child: Card(
        color: Colors.transparent,
        elevation: 10,
        child: FractionallySizedBox(
          widthFactor: 0.9,
          heightFactor: 0.9,
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