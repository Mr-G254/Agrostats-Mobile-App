import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Crops extends StatefulWidget{
  const Crops({super.key});

  @override
  State<Crops> createState() => _CropsState();
}

class _CropsState extends State<Crops>{

  @override
  Widget build(BuildContext context){
    final appBar = AppBar(
      backgroundColor: const Color(0xff255A6B),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.white,
        ),
        onPressed: (){
          Navigator.of(context).pop();
        },
      ),
      title: const Text(
        "Add a crop",
        style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontFamily: "Times"
        ),
      ),
    );

    final window = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: const Color(0xff6B8D01),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.topLeft,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        child: const Text(
                          "SELECT A CROP ICON",
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Times"
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

          ),
        )
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: Container(
        padding: const EdgeInsets.only(right: 0,left: 0),
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xff1b424e),
        child: window,
      ),
    );
  }
}