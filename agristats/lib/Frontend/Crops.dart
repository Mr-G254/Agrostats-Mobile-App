import 'package:agristats/Backend/FirebaseBackend.dart';
import 'package:agristats/Frontend/AddCrop.dart';
import 'package:flutter/material.dart';

class Crops extends StatefulWidget{
  const Crops({super.key});

  @override
  State<Crops> createState() => _CropsState();
}

class _CropsState extends State<Crops>{

  @override
  Widget build(BuildContext context){
    final addCropCard = AspectRatio(
        aspectRatio: 4.1,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Card(
            color: const Color(0xff6B8D01),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: const Text(
                    "Add  crop",
                    style: TextStyle(
                        fontSize: 20,
                        // color: Colors.white,
                        fontFamily: "Times"
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: AspectRatio(
                    aspectRatio: 1.1,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          color: const Color(0xff374804),
                          padding: const EdgeInsets.all(5),
                          child: const Image(
                            image: AssetImage("images/3d-leaf.png"),
                          ),
                        )
                    ),
                  ),
                )
              ],
            ),
          ),
        )
    );

    final appBar = AppBar(
      // backgroundColor: const Color(0xff255A6B),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_rounded,
          // color: Colors.white,
        ),
        onPressed: (){
          Navigator.of(context).pop();
        },
      ),
      title: const Text(
        "Crops",
        style: TextStyle(
            fontSize: 18,
            // color: Colors.white,
            fontFamily: "Times"
        ),
      ),
    );

    final window = Column(
      children: [
        GestureDetector(
          child: addCropCard,
          onTap: ()async{
            await Navigator.push(context, MaterialPageRoute(builder: (context) => const AddCrop())).then((value){
              setState(() {

              });
            });
          },
        ),
        Container(
          padding: const EdgeInsets.only(top: 0,right: 30,left: 30),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Crops",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Times",
                    // color: Colors.white
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(0),
                width: double.infinity,
                height: 5,
                child: const Divider(thickness: 2,),
              ),

            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(right: 10,left: 10),
          child: Column(
            children: FirebaseBackend.cropCards,
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
        // color: const Color(0xff1b424e),
        child: SingleChildScrollView(
          child: window,
        ),
      ),
    );
  }
}