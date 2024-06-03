import 'package:agristats/Frontend/Splashscreen.dart';
import 'package:flutter/material.dart';

void main()async{
  runApp(const App());
}

class App extends StatelessWidget{
  const App({super.key});

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      home:Scaffold(
        backgroundColor: Colors.white,
        body: Splashscreen(),
      )
    );
  }
}