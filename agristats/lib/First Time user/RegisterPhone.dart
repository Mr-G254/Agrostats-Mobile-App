import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../Backend/FirebaseBackend.dart';
import '../Common/Components.dart';
import 'VerifyPhone.dart';

class RegisterPhone extends StatefulWidget{
  const RegisterPhone({super.key});

  @override
  State<RegisterPhone> createState() => _RegisterPhoneState();
}

class _RegisterPhoneState extends State<RegisterPhone>{
  final name = TextEditingController();
  final phone = TextEditingController();

  String completePhoneNumber = "";
  bool loading = false;
  bool visible = false;

  void getnumber(String val){
    completePhoneNumber = val;
  }

  void showError(String error){
    showDialog(context: context, builder: (context) => DialogEr(infoType: "Error", info: error));
  }

  void showErrorObj(dynamic Object){
    showDialog(context: context, builder: (context) => DialogEr(infoType: "Error", info: Object.toString()));
    // Navigator.pop(context);
    setState(() {
      loading = false;
    });
  }

  void verifyPhonenumber(String verId){
    Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyPhone(name: name.text,phoneNumber: completePhoneNumber,verificationId: verId,)));
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

  startRegistrationProcess()async{
    if(name.text.isNotEmpty && phone.text.isNotEmpty){
      // if(completePhoneNumber.startsWith("+254")){
      //   completePhoneNumber = completePhoneNumber.substring(0,4) + completePhoneNumber.substring(5,completePhoneNumber.length);
      // }

      setState(() {
        visible = false;
        loading = true;
      });

      FirebaseBackend.verifyPhoneNumber(name.text,completePhoneNumber,verifyPhonenumber,showErrorObj);



    }else{
      setState(() {
        visible = true;
      });
    }
  }


  @override
  Widget build(BuildContext context){
    return Column(
      children: [
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
        PhoneInput(label: "PHONE NUMBER", editor: phone, type: TextInputType.phone,action: TextInputAction.done,phoneNumber: completePhoneNumber,callback: getnumber,),
        Container(
          padding: const EdgeInsets.only(top: 15,bottom: 15,right: 80,left: 80),
          width: double.infinity,
          height: 75,
          child: ElevatedButton(
              onPressed: (){
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
      ],
    );
  }
}