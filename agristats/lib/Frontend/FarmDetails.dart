import 'dart:ui';
import 'package:agristats/Backend/FirebaseBackend.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../Common/Components.dart';

class FarmDetails extends StatefulWidget {
  const FarmDetails({super.key});

  @override
  State<FarmDetails> createState() => _FarmDetailsState();
}

class _FarmDetailsState extends State<FarmDetails>{
  final size = TextEditingController();
  final location = TextEditingController();
  final soil = TextEditingController();

  bool loading = false;

  final loadingAnimation = LoadingAnimationWidget.threeArchedCircle(
      color: Colors.white,
      size: 30
  );

  final doneText = Text(
    FirebaseBackend.farmIsSetUp? "Save" : "Done",
    style: const TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontFamily: "Times"
    ),
  );

  void showErrorObj(Object){
    showDialog(context: context, builder: (context) => DialogEr(infoType: "Error", info: Object.toString()));
    setState(() {
      loading = false;
    });
  }

  void goBack(){
    Navigator.of(context).pop();
  }

  void setUpFarmDetails()async{
    setState(() {
      loading = true;
    });

    if(size.text.isNotEmpty && location.text.isNotEmpty && soil.text.isNotEmpty){
      await FirebaseBackend.setUpFarmDetails(size.text, location.text, soil.text, goBack, showErrorObj);

    }else{
      showErrorObj("Ensure that you fill in all the fields.");
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(FirebaseBackend.farmIsSetUp){
      final farm = FirebaseBackend.userFarm;
      size.text = farm.getSize();
      location.text = farm.getLocation();
      soil.text = farm.getSoil();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    size.dispose();
    location.dispose();
    soil.dispose();
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
        "Farm Details",
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
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: AspectRatio(
            aspectRatio: 2.1,
            child: Stack(
              children: [
                Container(
                    width: double.infinity,
                    height: double.infinity,
                    alignment: Alignment.center,
                    child: Card(
                      elevation: 10,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: const Image(
                        image: AssetImage("images/farrmmm.jpeg"),
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    )
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.topLeft,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        child: const Text(
                          "SET UP YOUR FARM",
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
                Container(
                  // padding: const EdgeInsets.all(5),
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    iconSize: 25,
                    icon: const Icon(Icons.info_outline,color: Colors.white,),
                    onPressed: (){
                      showDialog(context: context, builder: (context) => const DialogEr(infoType: "Information", info: "Help keep track of your farm by keying in the details."));
                    },
                  ),
                ),
              ],
            )
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Input(label: "SIZE(Acres)", editor: size, type: TextInputType.number, action: TextInputAction.next,backgroundColor: const Color(0xff255A6B)),
              Input(label: "LOCATION", editor: location, type: TextInputType.text, action: TextInputAction.next,backgroundColor: const Color(0xff255A6B)),
              Input(label: "SOIL TYPE", editor: soil, type: TextInputType.text, action: TextInputAction.done,backgroundColor: const Color(0xff255A6B)),
              const SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.only(top: 15,bottom: 15,right: 80,left: 80),
                width: double.infinity,
                height: 75,
                child: ElevatedButton(
                    onPressed: (){
                      setUpFarmDetails();
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                      backgroundColor: const Color(0xff6B8D01),
                    ),
                    child: loading? loadingAnimation : doneText,
                ),
              ),
            ],
          ),
        ),
        ],

    );

    return Scaffold(
      appBar: appBar,
      body: Container(
        padding: const EdgeInsets.only(right: 0,left: 0),
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