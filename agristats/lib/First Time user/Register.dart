import 'dart:ui';
import 'package:agristats/First%20Time%20user/RegisterEmail.dart';
import 'package:agristats/First%20Time%20user/RegisterPhone.dart';
import 'package:agristats/Frontend/Login.dart';
import 'package:flutter/material.dart';


class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> with TickerProviderStateMixin{
  // int _selectedIndex = 0;
  // late TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _controller = TabController(length: 2, vsync: this);
    //
    // _controller.animation?.addListener(() {
    //   setState(() {
    //     _selectedIndex = _controller.index;
    //   });
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){

    final column = Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SafeArea(
          child: Text(
             "Agrostats",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Times",
              fontSize: 35,
              fontWeight: FontWeight.bold
            ),
          )
        ),
        Container(
          height: 450,
          child: const Expanded(
            child: RegisterEmail(),
          ),
          // child: DefaultTabController(
          //     length: 2,
          //     child: Column(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Container(
          //           padding: const EdgeInsets.only(top: 10,bottom: 10,left: 40,right: 40),
          //           child: const TabBar(
          //             dividerColor: Colors.white60,
          //             tabs: [
          //               Tab(child: SizedBox(),)
          //               // Tab(child: Text("Email",style: TextStyle(fontFamily: "Times",fontSize: 15,color: Colors.white),),),
          //               // Tab(child: Text("Phone",style: TextStyle(fontFamily: "Times",fontSize: 15,color: Colors.white),),),
          //             ],
          //             indicatorColor: Colors.white,
          //             labelColor: Color(0xff1b424e),
          //           ),
          //         ),
          //         // Container(
          //         //   padding: const EdgeInsets.only(top: 10,bottom: 0,left: 30,right: 30),
          //         //   child: FlutterToggleTab(
          //         //     labels: const ["Email","Phone"],
          //         //     selectedIndex: _selectedIndex,
          //         //     selectedLabelIndex: (int index){
          //         //       setState(() {
          //         //         _selectedIndex = index;
          //         //         _controller.animateTo(index);
          //         //       });
          //         //     },
          //         //     borderRadius: 7,
          //         //     marginSelected: const EdgeInsets.all(3),
          //         //     selectedBackgroundColors: const [Color(0xff1b424e)],
          //         //     width: 50,
          //         //     height: 40,
          //         //     selectedTextStyle: const TextStyle(fontFamily: "Times",fontSize: 15,color: Colors.white),
          //         //     unSelectedTextStyle: const TextStyle(fontFamily: "Times",fontSize: 15,color: Colors.black),
          //         //   ),
          //         // ),
          //         const Expanded(
          //           child: TabBarView(
          //             children: [
          //               RegisterEmail(),
          //               RegisterPhone()
          //             ]
          //           ),
          //         )
          //
          //       ],
          //     )
          // ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Login())
          ),
          child: Container(
            padding: const EdgeInsets.only(bottom: 10),
            width: double.infinity,
            alignment: Alignment.center,
            child: const Text(
              "Already have an account? Log in",
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontFamily: "Times"
              ),
            ),
          ),
        ),

      ],

    );

    final window = Container(
      padding: const EdgeInsets.all(0),
      child: Card(
        color: Colors.transparent,
        elevation: 10,
        child: FractionallySizedBox(
          widthFactor: 0.9,
          heightFactor: 0.7,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: SingleChildScrollView(
                child: column,
              ),
            ),
          ),
        ),
      )
    );


    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("images/bg.png")
              )
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            padding: const EdgeInsets.all(0),
            alignment: Alignment.center,
            child: window,
          ),
        )
      ],
    );
  }

}