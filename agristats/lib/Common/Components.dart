import 'dart:ui';

import 'package:agristats/Backend/App.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class Input extends StatelessWidget{
  final String label;
  final TextEditingController editor;
  final TextInputType type;
  final TextInputAction action;
  final bool hideText;
  final String errorTxt;
  final bool showError;
  final Color backgroundColor;
  final bool enabled;
  final IconButton? icon;
  const Input({super.key,required this.label,required this.editor,required this.type,required this.action,this.hideText = false,this.errorTxt = "",this.showError = false,this.backgroundColor = Colors.transparent,this.enabled = true,this.icon});

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
            enabled: enabled,
            keyboardType: type,
            controller: editor,
            textInputAction: action,
            cursorColor: Colors.white,
            obscureText: hideText,
            style: TextStyle(
              height: 0.9,
              fontFamily: "Times",
              fontSize: 18,
              color: showError? Colors.red : Colors.white,
              fontWeight: FontWeight.normal
            ),
            decoration: InputDecoration(
              suffixIcon: icon,
              filled: true,
              fillColor: backgroundColor,
              errorText: showError? errorTxt : null,
              errorStyle: const TextStyle(
                  fontFamily: "Times",
                  fontSize: 10,
                  color: Colors.red,
                  fontWeight: FontWeight.normal
              ),
              disabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.white,width: 2)
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
  final String phoneNumber;
  final Function callback;
  const PhoneInput({super.key,required this.label,required this.editor,required this.type,required this.action,this.hideText = false,this.errorTxt = "",this.showError = false,required this.phoneNumber,required this.callback});

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


class DialogEr extends StatelessWidget{
  final String infoType;
  final String info;
  const DialogEr({super.key,required this.infoType,required this.info});

  @override
  Widget build(BuildContext context){
    return AlertDialog(
      title: Text(
        infoType,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 25,
            fontFamily: "Times",
            color: Colors.white
        ),
      ),
      content: Text(
        info,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 16,
            fontFamily: "Times",
            color: Colors.white
        ),
      ),
      backgroundColor: const Color(0xff1b424e),
      elevation: 10,
      alignment: Alignment.center,
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff6B8D01),
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
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
                  fontSize: 18
              ),
            )
        ),
      ],
    );
  }
}

class IconCard extends StatelessWidget{
  final String assetImg;
  final Function onTapCallback;
  const IconCard({super.key,required this.assetImg,required this.onTapCallback});

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: onTapCallback(assetImg),
      child: Card(
        elevation: 10,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: const Color(0xff906531),
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Image(
            image: AssetImage(assetImg),

          ),
        )
      ),
    );
  }
}

class CropCard extends StatelessWidget{
  final Crop crop;
  const CropCard({super.key,required this.crop});

  @override
  Widget build(BuildContext context){
    final remwks = ((int.parse(crop.duration)*7) - DateTime.now().difference(DateFormat("dd-MM-yyyy").parse(crop.plantingDate)).inDays)/7;
    
    return Container(
      padding: const EdgeInsets.all(0),
      width: double .infinity,
      height: MediaQuery.of(context).size.height/4,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("images/farmbg.jpg"),fit: BoxFit.cover,)
          ),
          child: Column(
            children: [
              Expanded(
                  flex: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                        color: const Color(0xff1b424e),
                        child: Container(
                          padding: const EdgeInsets.only(top: 5,bottom: 5,right: 10,left: 10),
                          child: Text(
                            crop.cropName,
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontFamily: "Times"
                            ),
                          ),
                        ),
                      ),
                      Card(
                        clipBehavior: Clip.antiAlias,
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                            side: const BorderSide(color: Colors.white,width: 2)
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.only(top: 5,right: 15,left: 15),
                                  child: const Text(
                                    "FERTILIZER",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontFamily: "Times"
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      padding: const EdgeInsets.only(left: 10),
                                      child: const Text(
                                        "TYPE",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                            fontFamily: "Times"
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10,),
                                    Container(
                                      width: 60,
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Text(
                                        crop.fertilizerType,
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Color(0xff1b424e),
                                            fontFamily: "Times",
                                            fontWeight: FontWeight.w900
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      padding: const EdgeInsets.only(left: 10),
                                      child: const Text(
                                        "AMT",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                            fontFamily: "Times"
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10,),
                                    Container(
                                      width: 60,
                                      padding: const EdgeInsets.only(right: 10,bottom: 5),
                                      child: Text(
                                        '${crop.fertilizerAmount}g',
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Color(0xff1b424e),
                                            fontFamily: "Times",
                                            fontWeight: FontWeight.w900
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 60,
                                      padding: const EdgeInsets.only(left: 10),
                                      child: const Text(
                                        "FREQ",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                            fontFamily: "Times"
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10,),
                                    Container(
                                      width: 60,
                                      padding: const EdgeInsets.only(right: 10,bottom: 5),
                                      child: Text(
                                        crop.fertilizerFrequency,
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Color(0xff1b424e),
                                            fontFamily: "Times",
                                            fontWeight: FontWeight.w900
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
              ),
              Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.all(0),
                    width: double.infinity,
                    child: Card(
                        clipBehavior: Clip.antiAlias,
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                            side: const BorderSide(color: Colors.white,width: 2)
                        ),
                        child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(right: 10,left: 10,top: 5),
                                          child: const Text(
                                            "Planting date",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontFamily: "Times"
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(right: 10,left: 10),
                                          child: Text(
                                            crop.plantingDate,
                                            style: const TextStyle(
                                                fontSize: 13,
                                                color: Color(0xff1b424e),
                                                fontFamily: "Times",
                                                fontWeight: FontWeight.w900
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      // crossAxisAlignment: CrossAxisAlignment,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(right: 10,left: 10,top: 5),
                                          child: const Text(
                                            "Duration",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontFamily: "Times"
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(right: 10,left: 10),
                                          child: Text(
                                            '${crop.duration}wks',
                                            style: const TextStyle(
                                                fontSize: 13,
                                                color: Color(0xff1b424e),
                                                fontFamily: "Times",
                                                fontWeight: FontWeight.w900
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 7,
                                        child: Container(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: LinearProgressIndicator(
                                            value: remwks/int.parse(crop.duration),
                                            color: Colors.white,
                                            backgroundColor: const Color(0xff1b424e),
                                            minHeight: 10,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        )
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: Container(
                                          padding: const EdgeInsets.only(right: 10,left: 10,bottom: 5),
                                          child: Text(
                                            '${remwks.toStringAsFixed(1)}wks',
                                            style: const TextStyle(
                                                fontSize: 13,
                                                color: Color(0xff1b424e),
                                                fontFamily: "Times",
                                                fontWeight: FontWeight.w900
                                            ),
                                          ),
                                        )
                                    )
                                  ],
                                )
                              ],
                            )
                        )
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

}


