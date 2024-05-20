import 'package:flutter/material.dart';

class Input extends StatelessWidget{
  final String label;
  final TextEditingController editor;
  final TextInputType type;
  final TextInputAction action;
  final bool hideText;
  const Input({super.key,required this.label,required this.editor,required this.type,required this.action,required this.hideText});

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.only(top: 10,bottom: 10,right: 30,left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: const TextStyle(
                fontSize: 13,
                fontFamily: "Times",
                color: Colors.white
            ),
          ),
          TextField(
            keyboardType: type,
            controller: editor,
            textInputAction: action,
            cursorColor: Colors.white,
            obscureText: hideText,
            style: const TextStyle(
              height: 0.9,
              fontFamily: "Times",
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.normal
            ),
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.white,width: 2)
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.white,width: 2)
              ),
            ),
          )
        ],
      ),
    );
  }


}