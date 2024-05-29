import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SetPhotoPage extends StatefulWidget {
  final XFile image;
  const SetPhotoPage({super.key, required this.image});

  @override
  State<SetPhotoPage> createState() => _SetPhotoPageState();
}

class _SetPhotoPageState extends State<SetPhotoPage>{
  bool loading = false;

  final loadingAnimation = LoadingAnimationWidget.threeArchedCircle(
      color: Colors.white,
      size: 30
  );

  final updateText = const Text(
    "Update profile",
    style: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontFamily: "Times"
    ),
  );

  @override
  Widget build(BuildContext context){
    final window = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          // width: double.infinity,
          padding: const EdgeInsets.only(top: 20),
          alignment: Alignment.center,
          child: ClipOval(
            child: Image.file(
              File(widget.image.path),
              height: 300,
              width: 300,
              fit: BoxFit.cover,

            ),
          ),
        ),
        const SizedBox(height: 50,),
        Container(
          padding: const EdgeInsets.only(top: 15,bottom: 15,right: 90,left: 90),
          width: double.infinity,
          height: 75,
          child: ElevatedButton(
              onPressed: (){
                // setState(() {
                //   loading = true;
                // });

              },
              style: ElevatedButton.styleFrom(
                elevation: 10,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                backgroundColor: const Color(0xff6B8D01),
              ),
              child: loading? loadingAnimation : updateText,
          ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: const Color(0xff255A6B),
      appBar: AppBar(
        backgroundColor: const Color(0xff1b424e),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white,),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: window
    );
  }
}