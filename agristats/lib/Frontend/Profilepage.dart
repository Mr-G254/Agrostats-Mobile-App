import 'package:agristats/Backend/FirebaseBackend.dart';
import 'package:agristats/Common/Components.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Profilepage extends StatefulWidget{
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage>{

  final name = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  bool loading = false;

  final loadingAnimation = LoadingAnimationWidget.threeArchedCircle(
      color: Colors.white,
      size: 30
  );

  final saveText = const Text(
    "Save",
    style: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontFamily: "Times"
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name.text = FirebaseBackend.userName;
    phone.text = FirebaseBackend.userPhone;
    email.text = FirebaseBackend.userEmail;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    name.dispose();
    phone.dispose();
    email.dispose();
    super.dispose();
  }

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
        "Profile Page",
        style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontFamily: "Times"
        ),
      ),
    );

    final window = Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20,bottom: 20),
          child: const CircleAvatar(
            backgroundColor: Colors.white,
            radius: 100,
            child: Image(
            image: AssetImage("images/user2.png"),
            height: 120,
            width: 120,
            ),
          ),
        ),
        Input(label: "NAME", editor: name, type: TextInputType.text, action: TextInputAction.next),
        Input(label: "EMAIL", editor: email, type: TextInputType.emailAddress, action: TextInputAction.next),
        Input(label: "PHONE NUMBER", editor: phone, type: TextInputType.phone, action: TextInputAction.done),
        Container(
          padding: const EdgeInsets.only(top: 15,bottom: 15,right: 80,left: 80),
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
            child: loading? loadingAnimation : saveText
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: Container(
        padding: const EdgeInsets.only(right: 10,left: 10),
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xff1b424e),
        child: SingleChildScrollView(
          child: window,
        ),
      ),
    );
  }
}