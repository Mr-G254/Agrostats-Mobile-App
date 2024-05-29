import 'package:camera/camera.dart';

abstract class CameraFeatures{
  static late List<CameraDescription> cameras;
  static late CameraDescription firstCamera;
  static late CameraDescription secondCamera;
  static late CameraController controller;
  static late CameraController controller2;
  static bool isInitialized = false;

  static void initializeCamera(List<CameraDescription> Cameras,CameraDescription FirstCamera,CameraDescription SecondCamera) {
    cameras = Cameras;
    firstCamera = FirstCamera;
    secondCamera = SecondCamera;
  }

}