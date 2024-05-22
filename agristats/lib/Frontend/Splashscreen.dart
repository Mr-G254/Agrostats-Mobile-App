import 'package:agristats/Backend/FirebaseBackend.dart';
import 'package:agristats/First%20Time%20user/GetStarted.dart';
import 'package:agristats/Frontend/Homepage.dart';
import 'package:agristats/Frontend/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Backend/firebase_options.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _Splashscreenstate();
}

class _Splashscreenstate extends State<Splashscreen>{

  bool? isFirstLaunch = false;

  void initializeApp()async{
    WidgetsFlutterBinding.ensureInitialized();
    await FirebaseBackend.initialize();

    SharedPreferences pref = await SharedPreferences.getInstance();
    if(pref.containsKey('firstTime')){
      // isFirstLaunch = pref.getBool('firstTime');
      SchedulerBinding.instance.addPostFrameCallback((timeStamp){
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => FirebaseBackend.isSignedIn? const Homepage() : const Login())
        );
      });
    }else{
      await pref.setBool('firstTime', false);

      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const GetStarted())
        );
      });
    }


  }

  @override
  void initState(){
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 3),() => initializeApp());
  }

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(0),
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xff1b424e),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Agrostats",
            style: TextStyle(
              color: Color(0xff6B8D01),
              fontFamily: "Times",
              fontSize: 45,
              fontWeight: FontWeight.bold
            ),
          ),
          const Text(
            "Effortless farming, seamless tracking",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Times",
                fontSize: 15,
                // fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 40,),
          LoadingAnimationWidget.fourRotatingDots(
            color: Colors.white,
            size: 40
          )

        ],
      ),
    );
  }
}