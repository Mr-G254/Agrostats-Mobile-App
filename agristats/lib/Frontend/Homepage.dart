import 'package:agristats/Backend/FirebaseBackend.dart';
import 'package:agristats/Frontend/Profilepage.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>{

  String greetings = "";
  String fullName = "";

  Future<void> getName()async{
    String name = await FirebaseBackend.getUserName();
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
    getName();
  }

  @override
  Widget build(BuildContext context){
    var bellIcon = Container(
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
            child: const CircleAvatar(
              radius: 8,
              backgroundColor: Color(0xff6B8D01),
              child: Text(
                "5",
                style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontFamily: "Times"
                ),
              ),
            ),
          ),
        ],
      ),
    );

    final appBar = AppBar(
      backgroundColor: const Color(0xff255A6B),
      leadingWidth: 300,
      leading: Container(
        padding: const EdgeInsets.all(10),
        child: Text(
          greetings,
          style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontFamily: "Times"
          ),
        ),
      ),
      actions: [
        bellIcon,
        Builder(
          builder: (context) => GestureDetector(
            // child: Container(
            //   padding: const EdgeInsets.only(top: 10,bottom: 10,right: 10,left: 10),
            //   child: const Image(
            //     image: AssetImage("images/user.png"),
            //     width: 50,
            //     height: 50,
            //   ),
            // ),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: AspectRatio(
                aspectRatio: 1.1,
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.white,
                      child: const Image(
                        height: 30,
                        width: 30,
                        image: AssetImage("images/user2.png"),
                      ),
                    )
                ),
              ),
            ),
            onTap: () => Scaffold.of(context).openDrawer(),
          )
        )
      ],
    );

    final menu  = Drawer(
      shape: const RoundedRectangleBorder(),
      backgroundColor: const Color(0xff255A6B),
      child: ListView(
        padding: const EdgeInsets.only(right: 5,left: 5),
        children: [
          SafeArea(
            child: ListTile(
              contentPadding: const EdgeInsets.only(left: 7,right: 10,top: 0,bottom: 0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              tileColor: const Color(0xff1b424e),
              leading: Container(
                  child: AspectRatio(
                    aspectRatio: 1.1,
                    child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          color: Colors.white,
                          child: const Image(
                            height: 25,
                            width: 25,
                            image: AssetImage("images/user2.png"),
                          ),
                        )
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
                    color: Colors.white,
                    fontFamily: "Times"
                ),
              ),
              subtitle: const Text(
                "Profile Settings",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white60,
                    fontFamily: "Times"
                ),
              ),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Profilepage()));
              },
            ),
          )
        ],
      ),
    );

    final window = const Column(

    );

    return Scaffold(
      drawer: menu,
      appBar: appBar,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xff1b424e),
        child: window,
      ),
    );
  }
}