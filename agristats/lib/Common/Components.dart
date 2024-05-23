import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class Input extends StatelessWidget{
  final String label;
  final TextEditingController editor;
  final TextInputType type;
  final TextInputAction action;
  final bool hideText;
  final String errorTxt;
  final bool showError;
  const Input({super.key,required this.label,required this.editor,required this.type,required this.action,this.hideText = false,this.errorTxt = "",this.showError = false});

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.only(top: 10,bottom: 10,right: 30,left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: TextStyle(
                fontSize: 13,
                fontFamily: "Times",
                color: showError? Colors.red : Colors.white
            ),
          ),
          TextField(
            keyboardType: type,
            controller: editor,
            textInputAction: action,
            cursorColor: Colors.white,
            obscureText: hideText,
            style: TextStyle(
              height: 0.9,
              fontFamily: "Times",
              fontSize: 20,
              color: showError? Colors.red : Colors.white,
              fontWeight: FontWeight.normal
            ),
            decoration: InputDecoration(
              errorText: showError? errorTxt : null,
              errorStyle: const TextStyle(
                  fontFamily: "Times",
                  fontSize: 10,
                  color: Colors.red,
                  fontWeight: FontWeight.normal
              ),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.white,width: 2)
              ),
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.white,width: 2)
              ),
              errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.red,width: 2)
              ),
              focusedErrorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.red,width: 2)
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PhoneInput extends StatelessWidget{
  final String label;
  final TextEditingController editor;
  final TextInputType type;
  final TextInputAction action;
  final bool hideText;
  final String errorTxt;
  final bool showError;
  String phoneNumber;
  final Function callback;
  PhoneInput({super.key,required this.label,required this.editor,required this.type,required this.action,this.hideText = false,this.errorTxt = "",this.showError = false,required this.phoneNumber,required this.callback});

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.only(top: 10,bottom: 10,right: 30,left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: TextStyle(
                fontSize: 13,
                fontFamily: "Times",
                color: showError? Colors.red : Colors.white
            ),
          ),
          IntlPhoneField(
            initialCountryCode: 'KE',
            keyboardType: type,
            controller: editor,
            textInputAction: action,
            cursorColor: Colors.white,
            obscureText: hideText,
            dropdownIcon: const Icon(Icons.arrow_drop_down_sharp,color: Colors.white,),
            dropdownTextStyle: const TextStyle(fontFamily: "Times",color: Colors.white),
            onChanged: (value)=> callback(value.completeNumber),
            style: TextStyle(
                height: 0.9,
                fontFamily: "Times",
                fontSize: 20,
                color: showError? Colors.red : Colors.white,
                fontWeight: FontWeight.normal
            ),
            decoration: InputDecoration(
              counterStyle: const TextStyle(fontFamily: "Times",color: Colors.white),
              errorText: showError? errorTxt : null,
              errorStyle: const TextStyle(
                  fontFamily: "Times",
                  fontSize: 10,
                  color: Colors.red,
                  fontWeight: FontWeight.normal
              ),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.white,width: 2)
              ),
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.white,width: 2)
              ),
              errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.red,width: 2)
              ),
              focusedErrorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.red,width: 2)
              ),
            ),
          )
        ],
      ),
    );
  }

}

class DialogInfo extends StatelessWidget{
  final String infoType;
  final String info;
  const DialogInfo({super.key,required this.infoType,required this.info});

  @override
  Widget build(BuildContext context){
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: FractionallySizedBox(
        heightFactor: 0.4,
        widthFactor: 0.9,
        child: Card(
          color: const Color(0xff1b424e),
          elevation: 10,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Text(
                  infoType,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 30,
                      fontFamily: "Times",
                      color: Colors.white
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Text(
                  info,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20,
                      fontFamily: "Times",
                      color: Colors.white
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 80,
                padding: const EdgeInsets.only(right: 50,left: 50,top: 15,bottom: 20),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff6B8D01),
                        elevation: 5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                    ),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Ok",
                      style: TextStyle(
                          fontFamily: "Times",
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),
                    )
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}