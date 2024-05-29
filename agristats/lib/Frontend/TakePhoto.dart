import 'package:agristats/Frontend/CameraFeatures.dart';
import 'package:agristats/Frontend/SetPhotopage.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Common/Components.dart';

class TakePhoto extends StatefulWidget{
  const TakePhoto({super.key});

  @override
  State<TakePhoto> createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto>{
  bool cameraIsReady = false;
  bool selfie = false;

  late CameraController selfieCamera;
  late CameraController backCamera ;

  void showErrorObj(Object){
    showDialog(context: context, builder: (context) => DialogEr(infoType: "Error", info: Object.toString()));

  }

  Future<void> initializeCamera()async{
    backCamera = CameraController(CameraFeatures.firstCamera, ResolutionPreset.high,enableAudio: false);
    selfieCamera = CameraController(CameraFeatures.secondCamera, ResolutionPreset.high,enableAudio: false);

    await backCamera.initialize().then((value) {
      setState(() {
        cameraIsReady = true;
      });
    });

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeCamera();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    selfieCamera.dispose();
    backCamera.dispose();
    super.dispose();
  }

  final loadingAnimation = LoadingAnimationWidget.threeArchedCircle(
      color: Colors.white,
      size: 30
  );

  void goToNextPage(XFile image){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SetPhotoPage(image: image)));
  }

  Widget build(BuildContext context){
    final camera = Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.topCenter,
          child: CameraPreview(selfie? selfieCamera : backCamera),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 5),
          child: Card(
            color: const Color(0xff1b424e),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 60,
                  height: 50,
                  child: IconButton(
                      onPressed: ()async{
                        final image = selfie? await selfieCamera.takePicture() : await backCamera.takePicture();
                        goToNextPage(image);
                      },
                      icon: const Icon(Icons.camera,color: Colors.white,size: 30,)
                  ),
                ),
                Container(
                    height: 50,
                    width: 60,
                    child: TextButton(
                      onPressed: ()async{
                        if(selfie){
                          await backCamera.initialize().then((value) {
                            setState(() {
                              selfie = !selfie;
                            });
                          });
                        }else{
                          await selfieCamera.initialize().then((value) {
                            setState(() {
                              selfie = !selfie;
                            });
                          });
                        }

                      },
                      child: const Image(image: AssetImage("images/reload.png"),height: 30,width: 30,),
                    )
                )
              ],
            ),
          ),
        )
      ],
    );

    return Scaffold(
      backgroundColor: const Color(0xff255A6B),
      body: cameraIsReady? camera : Center(child: loadingAnimation,),
      appBar: AppBar(
        backgroundColor: const Color(0xff1b424e),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white,),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}