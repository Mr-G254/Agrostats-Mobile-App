import 'dart:ui';

import 'package:agristats/Backend/FirebaseBackend.dart';
import 'package:agristats/Backend/WeatherAPI.dart';
import 'package:agristats/Frontend/About.dart';
import 'package:agristats/Frontend/Crops.dart';
import 'package:agristats/Frontend/FarmDetails.dart';
import 'package:agristats/Frontend/Login.dart';
import 'package:agristats/Frontend/Profilepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import '../Common/Components.dart';
import 'Support.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>{

  String greetings = "";
  String fullName = "";
  bool on = true;
  ThemeMode _themeMode = ThemeMode.system;

  void updateNotification(){
    setState(() {

    });
  }


  void showErrorObj(Object){
    showDialog(context: context, builder: (context) => DialogEr(infoType: "Error", info: Object.toString()));
  }

  Future<void> getName()async{
    String name = await FirebaseBackend.getUserName()?? "";
    List<String> names = name.split(" ");
    setState(() {
      fullName = name;
      greetings = "Hi, ${names[0]}";
    });
  }

  void setName(){
    String name = FirebaseBackend.userName;
    List<String> names = name.split(" ");
    setState(() {
      fullName = name;
      greetings = "Hi, ${names[0]}";
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(FirebaseBackend.userName.isEmpty){
      getName();
    }else{
      setName();
    }


  }

  void goToLoginPage(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Login()), (route) => false);
  }

  final userProfile = Image(image: NetworkImage(FirebaseBackend.profilePhotoUrl),height: 30,width: 30,fit: BoxFit.cover,);
  final noprofile = Container(
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child:const Image(
        height: 30,
        width: 30,
        image: AssetImage("images/user2.png"),
      )
  );


  @override
  Widget build(BuildContext context){
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final appBar = AppBar(
      // backgroundColor: const Color(0xff255A6B),
      leadingWidth: 300,
      leading: Container(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              greetings,
              style: const TextStyle(
                  fontSize: 18,
                  // color: Colors.white,
                  fontFamily: "Times"
              ),
            ),
            Text(
              "Welcome",
              style: TextStyle(
                  fontSize: 15,
                  color: isDarkMode ? Colors.white60 : Colors.black54,
                  fontFamily: "Times"
              ),
            ),
          ],
        )
      ),
      actions: [
        Builder(
          builder: (context) => GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: AspectRatio(
                aspectRatio: 1.1,
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: FirebaseBackend.profilePhotoUrl.isEmpty? noprofile : userProfile,
                ),
              ),
            ),
            onTap: () => Scaffold.of(context).openDrawer(),
          )
        )
      ],
    );

    final menu  = Container(
      padding: const EdgeInsets.only(right: 5,left: 5,top: 5),
      child: Column(
        children: [
          SafeArea(
            child: ListTile(
              contentPadding: const EdgeInsets.only(left: 7,right: 10,top: 0,bottom: 0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              // tileColor: const Color(0xff1b424e),
              leading: Container(
                  child: AspectRatio(
                    aspectRatio: 1.1,
                    child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        child: FirebaseBackend.profilePhotoUrl.isEmpty? noprofile : userProfile,
                    ),
                  )
              ),
              trailing: GestureDetector(
                child: const Image(
                  color: Colors.white,
                  image: AssetImage("images/settings.png"),
                  height: 28,
                  width: 28,
                ),
              ),
              title: Text(
                fullName,
                style: const TextStyle(
                    fontSize: 15,
                    // color: Colors.white,
                    fontFamily: "Times"
                ),
              ),
              subtitle: const Text(
                "Profile Settings",
                style: TextStyle(
                    fontSize: 12,
                    // color: Colors.white60,
                    fontFamily: "Times"
                ),
              ),
              onTap: ()async{
                Navigator.of(context).pop();
                await Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Profilepage())).then((value){
                  setState(() {

                  });
                });
              },
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 20),
            child: Card(
              // color: const Color(0xff1b424e),
              // surfaceTintColor: const Color(0xff1b424e),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child:  Column(
                children: [
                  ListTile(
                    visualDensity: const VisualDensity(vertical: 1),
                    title: const Text(
                      "Farm details",
                      style: TextStyle(
                          fontSize: 16,
                          // color: Colors.white,
                          fontFamily: "Times"
                      ),
                    ),
                    trailing: Visibility(
                      visible: !FirebaseBackend.farmIsSetUp,
                      child: const Icon(Icons.info,color: Colors.redAccent,)
                    ),
                    onTap: (){
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const FarmDetails()));
                    },
                  ),
                  Container(
                    height: 1,
                    padding: const EdgeInsets.only(right: 10,left: 10),
                    child: const Divider(
                      thickness: 1,
                      // color: Colors.white,
                    ),
                  ),
                  ListTile(
                    visualDensity: const VisualDensity(vertical: 1),
                    title: const Text(
                      "Crops",
                      style: TextStyle(
                          fontSize: 16,
                          // color: Colors.white,
                          fontFamily: "Times"
                      ),
                    ),
                    onTap: ()async{
                      Navigator.of(context).pop();
                      await Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const Crops())).then((val){
                        setState(() {

                        });
                      });
                    },
                  ),
                  Container(
                    height: 1,
                    padding: const EdgeInsets.only(right: 10,left: 10),
                    child: const Divider(
                      thickness: 1,
                      // color: Colors.white,
                      ),
                  ),
                  // const ListTile(
                  //   visualDensity: VisualDensity(vertical: 1),
                  //   title: Text(
                  //     "Farmer's Checklist",
                  //     style: TextStyle(
                  //         fontSize: 16,
                  //         // color: Colors.white,
                  //         fontFamily: "Times"
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   height: 1,
                  //   padding: const EdgeInsets.only(right: 10,left: 10),
                  //   child: const Divider(
                  //     thickness: 1,
                  //     // color: Colors.white,
                  // ),
                  // ),
                  // const ListTile(
                  //   visualDensity: VisualDensity(vertical: 1),
                  //   title: Text(
                  //     "Certification",
                  //     style: TextStyle(
                  //         fontSize: 16,
                  //         // color: Colors.white,
                  //         fontFamily: "Times"
                  //     ),
                  //   ),
                  // ),
                  Container(
                    height: 1,
                    padding: const EdgeInsets.only(right: 10,left: 10),
                    child: const Divider(
                      thickness: 1,
                      // color: Colors.white,
                    ),
                  ),
                  ListTile(
                    visualDensity: const VisualDensity(vertical: 1),
                    title: const Text(
                      "Support",
                      style: TextStyle(
                          fontSize: 16,
                          // color: Colors.white,
                          fontFamily: "Times"
                      ),
                    ),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Support()));

                    },
                  ),
                  Container(
                    height: 1,
                    padding: const EdgeInsets.only(right: 10,left: 10),
                    child: const Divider(
                      thickness: 1,
                      // color: Colors.white,
                    ),
                  ),
                  ListTile(
                    visualDensity: const VisualDensity(vertical: 1),
                    title: const Text(
                      "About",
                      style: TextStyle(
                          fontSize: 16,
                          // color: Colors.white,
                          fontFamily: "Times"
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => AboutUsPage()));
                    }

                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10,),
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(bottom: 10),
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: (){
                    FirebaseBackend.logOut(showErrorObj,goToLoginPage);
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(150, 45),
                    elevation: 10,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    backgroundColor: const Color(0xff6B8D01),
                  ),
                  child: const Text(
                    "Logout",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: "Times"
                    ),
                  )
              ),
            ),
          ),
        ],
      ),
    );

    final weatherCard = AspectRatio(
      aspectRatio: 2.1,
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          backgroundBlendMode: BlendMode.lighten,
          // color: const Color(0xffadd9a6),
          gradient: const LinearGradient(
            colors: [
              Color(0xffadd9a6),
              Color(0xff255A6B),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "TEMP\n(C)",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: "Times"
                  ),
                ),
                Text(
                  WeatherAPI.currentWeather!.temperature!.celsius!.toStringAsFixed(2),
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: "Times"
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "HUM\n(%)",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: "Times"
                  ),
                ),
                Text(
                  WeatherAPI.currentWeather!.humidity!.toStringAsFixed(2),
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: "Times"
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "WIND\n(m/s)",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: "Times"
                  ),
                ),
                Text(
                  WeatherAPI.currentWeather!.windSpeed!.toStringAsFixed(2),
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: "Times"
                  ),
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: const Image(
                image: AssetImage("images/sun.png"),
                width: 100,
                height: 100,
              ),
            )
          ],
        ),
      ),
    );

    final window = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Dashboard",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: "Times"
                ),
              ),
              ImageSlideshow(
                autoPlayInterval: 3000,
                indicatorBottomPadding: 5,
                indicatorRadius: 4,
                indicatorColor: const Color(0xff1b424e),
                indicatorBackgroundColor: Colors.white,
                isLoop: FirebaseBackend.cropWidget.length > 1,
                children: FirebaseBackend.cropWidget,
              )
            ],
          ),
        ),
        weatherCard,
        Container(
          padding: const EdgeInsets.all(0),
          height: 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10),
                child: const Text(
                  "Notifications",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: "Times"
                  ),
                ),
              ),
              // bellIcon
              Container(
                width: 55,
                height: 55,
                padding: const EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: const Image(
                        image: AssetImage("images/notify.png"),
                        width: 20,
                        height: 20,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: const Color(0xff6B8D01),
                        child: Text(
                          FirebaseBackend.notificationWidgets.length.toString(),
                          style: const TextStyle(
                              fontSize: 10,
                              // color: Colors.white,
                              fontFamily: "Times"
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: FirebaseBackend.notificationWidgets,
            ),
          )
        )
      ],

    );

    FirebaseBackend.notifyCallback = updateNotification;

    return Scaffold(
      drawer: Drawer(
        shape: const RoundedRectangleBorder(),
        // backgroundColor: const Color(0xff255A6B),
        child: menu,
      ),
      appBar: appBar,
      body: window
    );
  }
}