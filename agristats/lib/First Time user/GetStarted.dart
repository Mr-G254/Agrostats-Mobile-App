import 'package:agristats/First%20Time%20user/Register.dart';
import 'package:flutter/material.dart';

class GetStarted extends StatelessWidget{
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context){
    final window = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: ClipPath(
            clipper: MyClipper(),
            child: Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.centerLeft,
              height: double.infinity,
              width: double.infinity,
              color: const Color(0xff374804),
              child: const Image(
                width: 250,
                height: 250,
                image: AssetImage('images/3d-leaf.png')
              )
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 20,right: 10),
              child: const Text(
                "Welcome To Agrostats",
                textAlign: TextAlign.left,
                style: TextStyle(
                  height: 1.1,
                  color: Color(0xff6B8D01),
                  fontFamily: "Times",
                  fontWeight: FontWeight.bold,
                  fontSize: 45,

                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: const Text(
                "Effortless Farming, Seamless Tracking",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Times",
                  fontWeight: FontWeight.w200
                ),
              ),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          height: 50,
          padding: const EdgeInsets.only(right: 50,left: 50),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff374804),
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
              ),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Register()),
                );
              },
              child: const Text(
                "GET STARTED",
                style: TextStyle(
                    fontFamily: "Times",
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
              )
          ),
        )
      ],
    );

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 20),
        width: double.infinity,
        height: double.infinity,
        child: window
      ),
    );
  }
}


class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    // Define a custom path to create a stylish clipped shape
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height*0.8);
    path.quadraticBezierTo(size.width*0.6, size.height, size.width, size.height*0.5);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }

}