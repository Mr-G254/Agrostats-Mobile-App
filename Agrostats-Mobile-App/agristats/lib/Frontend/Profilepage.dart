import 'package:agristats/Backend/FirebaseBackend.dart';
import 'package:agristats/Common/Components.dart';
import 'package:agristats/Frontend/SetPhotopage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Profilepage extends StatefulWidget{
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage>{

  final name = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  bool loading = false;
  final picker = ImagePicker();

  final loadingAnimation = LoadingAnimationWidget.threeArchedCircle(
      color: Colors.white,
      size: 30
  );

  final saveText = const Text(
    "Save",
    style: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontFamily: "Times"
    ),
  );

  void goToNextPage(XFile image){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SetPhotoPage(image: image)));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name.text = FirebaseBackend.userName;
    phone.text = FirebaseBackend.userPhone;
    email.text = FirebaseBackend.userEmail;

  }

  @override
  void dispose() {
    // TODO: implement dispose
    name.dispose();
    phone.dispose();
    email.dispose();
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
        "Profile Page",
        style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontFamily: "Times"
        ),
      ),
    );

    final profile = Container(
      padding: const EdgeInsets.only(top: 20,bottom: 20),
      alignment: Alignment.center,
      child: const CircleAvatar(
        backgroundColor: Colors.white,
        radius: 100,
        child: Image(
          image: AssetImage("images/user2.png"),
          height: 120,
          width: 120,
        ),
      ),
    );

    final userPhoto = Container(
      // width: double.infinity,
      padding: const EdgeInsets.only(top: 20),
      alignment: Alignment.center,
      child: ClipOval(
        child: Image(
          image: NetworkImage(FirebaseBackend.profilePhotoUrl),
          height: 250,
          width: 250,
          fit: BoxFit.cover,
        )
      ),
    );

    final images = Container(
      padding: EdgeInsets.only(top: 10),
      child: Card(
        color: const Color(0xff255A6B),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 45,
              child: IconButton(
                  onPressed: ()async{
                    final image = await picker.pickImage(source: ImageSource.camera);
                    if(image != null){
                      goToNextPage(image);
                    }

                  },
                  icon: const Icon(Icons.camera,color: Colors.white,size: 25,)
              ),
            ),
            Container(
              width: 60,
              height: 45,
              child: IconButton(
                  onPressed: ()async{
                    final image = await picker.pickImage(source: ImageSource.gallery);
                    if(image != null){
                      goToNextPage(image);
                    }
                  },
                  icon: const Icon(Icons.image_rounded,color: Colors.white,size: 25,)
              ),
            ),
          ],
        ),
      ),
    );

    final window = Column(
      children: [
        FirebaseBackend.profilePhotoUrl.isEmpty? profile : userPhoto,
        images,
        Input(label: "NAME", editor: name, type: TextInputType.text, action: TextInputAction.next,backgroundColor: const Color(0xff255A6B),enabled: false,),
        Input(label: "EMAIL", editor: email, type: TextInputType.emailAddress, action: TextInputAction.next,backgroundColor: const Color(0xff255A6B),enabled: false,),
        Input(label: "PHONE NUMBER", editor: phone, type: TextInputType.phone, action: TextInputAction.done,backgroundColor: const Color(0xff255A6B),enabled: false,),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: Container(
        padding: const EdgeInsets.only(right: 20,left: 20),
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