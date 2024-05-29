import 'package:agristats/Frontend/CameraFeatures.dart';
import 'package:agristats/Frontend/Splashscreen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  final secondCamera = cameras.elementAt(1);

  CameraFeatures.initializeCamera(cameras, firstCamera, secondCamera);

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