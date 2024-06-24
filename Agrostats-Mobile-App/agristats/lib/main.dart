import 'package:agristats/Backend/App.dart';
import 'package:agristats/Frontend/Splashscreen.dart';
import 'package:flutter/material.dart';

void main()async{
  runApp(const App());
}

class App extends StatelessWidget{
  const App({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: MyAppThemes.lightTheme,
      darkTheme: MyAppThemes.darkTheme,
      themeMode: ThemeMode.system,
      home:const Scaffold(
        backgroundColor: Colors.white,
        body: Splashscreen(),
      )
    );
  }
}