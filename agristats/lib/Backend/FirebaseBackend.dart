import 'dart:io';
import 'package:agristats/Backend/App.dart';
import 'package:agristats/Backend/WeatherAPI.dart';
import 'package:agristats/Common/Components.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'firebase_options.dart';

abstract class FirebaseBackend{
  static bool isSignedIn = false;
  static String userName = "";
  static String userEmail = "";
  static String userPhone = "";
  static String profilePhotoUrl = "";
  static bool farmIsSetUp = false;
  static late FarmDetails userFarm;

  static List<Crop> crop = [];
  static List<Widget> cropWidget = [];
  static List<Widget> cropCards = [];

  static List<NotificationTile> notificationWidgets = [];
  static Function? notifyCallback;

  static Future<void> initialize()async{
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    if(FirebaseAuth.instance.currentUser != null){
      isSignedIn = true;
      await FirebaseBackend.getAppData();
    }

    await WeatherAPI.initialize();
  }

  static User? getCurrentUser(){
    return FirebaseAuth.instance.currentUser;
  }

  static Future<void> verifyPhoneNumber(String name,String number,Function onCodeSent,Function onError)async{
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (PhoneAuthCredential credential){
        },
        verificationFailed: (FirebaseAuthException e){onError(e);},
        codeSent: (String verificationId, int? resendToken){
          onCodeSent(verificationId);

          userName = name;
          userPhone = number;
          userEmail = "";
        },
        codeAutoRetrievalTimeout: (String verificationId){}
    );
  }

  static Future<PhoneAuthCredential> confirmPhoneNumberVerified(String verId,String code)async{
    final cred = PhoneAuthProvider.credential(verificationId: verId, smsCode: code);
    return cred;
  }

  static Future<void> signInUsingPhoneCredential(PhoneAuthCredential cred)async{
    await FirebaseAuth.instance.signInWithCredential(cred);
  }

  static Future<void> registerUser(String name,String email,String password,Function onCompletion,Function onError)async{
    bool emailexist = await FirebaseBackend.checkIfEmailExists(email);

    if(emailexist){
      onError("The email is already in use");
    }else{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) => FirebaseBackend.addUserToDb(name, email, "", onCompletion, onError)).catchError(onError);

      userName = name;
      userEmail = email;
      userPhone = "";
    }
  }

  static Future<void> signInWithEmailAndPassword(String email,String password,Function onCompletion,Function onError)async{
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) async{

      await FirebaseBackend.getAppData();
      onCompletion();
    }).catchError(onError);

  }

  static Future<void> passwordReset(String email,Function onCompletion,Function onError)async{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) => onCompletion).catchError(onError);
  }

  static Future<void> verifyEmail(Function onCodeSent)async{
    final user = FirebaseAuth.instance.currentUser;

    if(user != null) {
      user.sendEmailVerification().then((value) => onCodeSent());
    }

  }

  static Future<bool> checkIfEmailIsVerified(Function onError)async{
    final user = FirebaseAuth.instance.currentUser;

    if(user != null) {
      await user.reload().catchError(onError);
      return user.emailVerified;
    }else{
      return false;
    }

  }

  static Future<void>getAppData()async{
    await FirebaseBackend.getProfile();
    await FirebaseBackend.getUserName();

    farmIsSetUp = await FirebaseBackend.checkIfFarmDetails();
    if(farmIsSetUp){
      await FirebaseBackend.getFarmDetails();
      await FirebaseBackend.getAllCrops();
    }
  }

  static Future<void> addUserToDb(String name,String email,String phone,Function onCompletion,Function onError)async{
    final userDb = FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid);
    final snapshot = await userDb.get();

    if(snapshot.docs.isEmpty){
      final user = <String,dynamic>{
        "iud" : FirebaseAuth.instance.currentUser?.uid ?? "",
        "name" : name,
        "email" : email,
        "phone" : phone,
      };

      await userDb.doc("User Details").set(user).then((value) async{
        if(email.isNotEmpty){
          await FirebaseFirestore.instance.collection("User emails").add({"email": email}).then((value) => onCompletion()).catchError(onError);
        }

      }).catchError(onError);
    }

  }

  static Future<bool> checkIfEmailExists(String email)async{
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection("User emails").where("email",isEqualTo: email).get();
    final data  = snapshot.docs;

    if(data.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }

  static Future<String> getUserName()async{
    userEmail = FirebaseAuth.instance.currentUser!.email ?? "";
    userPhone = FirebaseAuth.instance.currentUser!.phoneNumber ?? "";

   DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("User Details").get();
   final data  = snapshot.data();

   if(snapshot.exists){
     String? name = data?["name"] as String?;
     userName = name!;
      return name ?? "";
   }else{
     return "";
   }
  }

  static Future<void> logOut(Function onError,Function onCompletion)async{
    await FirebaseAuth.instance.signOut().then((value) => onCompletion()).catchError(onError());
    userName = "";
    userEmail = "";
    userPhone = "";
    profilePhotoUrl = "";
  }

  static Future<void> uploadProfile(XFile profileImage,Function onCompletion,Function onError)async{
    final storageRef = FirebaseStorage.instance.ref().child('profiles/${FirebaseAuth.instance.currentUser!.uid}/profile.png');
    await storageRef.putFile(File(profileImage.path)).catchError(onError).then((value) async{
      await FirebaseBackend.getProfile();
      onCompletion();
    });

  }

  static Future<void> getProfile()async{
    final storageRef = FirebaseStorage.instance.ref().child('profiles/${FirebaseAuth.instance.currentUser!.uid}/profile.png');
    profilePhotoUrl = await storageRef.getDownloadURL().catchError((e){return "";});

  }

  static Future<void> setUpFarmDetails(String size,String location,String soil,Function onCompletion,Function onError)async{
    final userDb = FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("Farm Details");

    final farm = <String,dynamic>{
      "size" : size,
      "location" : location,
      "soil" : soil,
    };

    userFarm = FarmDetails(size: size, location: location, soil: soil);
    farmIsSetUp = true;
    await userDb.set(farm).then((value) => onCompletion()).catchError(onError);

  }

  static Future<bool> checkIfFarmDetails()async{
    final userDb = FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("Farm Details");
    final data = await userDb.get();

    if(data.exists){
      return true;
    }else{
      return false;
    }
  }

  static Future<void> getFarmDetails()async{
    if(farmIsSetUp){
      final userDb = FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("Farm Details");
      final data = await userDb.get();

      userFarm = FarmDetails(size: data['size'], location: data['location'], soil: data['soil']);
    }

  }

  static Future<void> addCrop(Crop crop,Function onCompletion)async{
    final userDb = FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("Crop Details").collection("Crops");
    await userDb.doc(crop.getCropName()).set(crop.toMap()).then((value)async{
      await FirebaseBackend.getAllCrops();
      onCompletion();
    });

  }

  static Future<void> getAllCrops()async{
    crop.clear();
    cropWidget.clear();
    cropCards.clear();
    notificationWidgets.clear();

    final userDb = FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("Crop Details").collection("Crops");
    final snapshot = await userDb.get();

    for(final data in snapshot.docs){
      final fertDates = List<String>.from(data['fertilizerApplicationDates']);
      final herbDates = List<String>.from(data['herbicideApplicationDates']);

      final cropData = Crop(cropName: data['name'], plantingDate: data['plantingDate'], duration: data['duration'], landOccupied: data['landOccupied'], fertilizerAmount: data['fertilizerAmount'], fertilizerType: data['fertilizerType'], fertilizerFrequency: data['fertilizerApplicationFrequency'], herbicideAmount: data['herbicideAmount'], herbicideType: data['herbicideType'], herbicideFrequency: data['herbicideApplicationFrequency'],fertilizerApplicationDates: fertDates,herbicideApplicationDates: herbDates);
      crop.add(cropData);
      cropWidget.add(CropCard(crop: cropData));
      cropCards.add(CropTile(crop: cropData));

      final now  = DateTime.now();
      for(final i in fertDates){

        if(DateFormat('dd-MM-yyyy').parse(i).isAfter(DateTime.now().subtract(const Duration(days: 1)))){
          if(DateFormat('dd-MM-yyyy').parse(i).isAtSameMomentAs(DateTime(now.year,now.month,now.day))){
            notificationWidgets.insert(0,NotificationTile(notification: Notify(cropName: data['name'], activity: "Fertilizer", date: i)));
          }else{
            notificationWidgets.add(NotificationTile(notification: Notify(cropName: data['name'], activity: "Fertilizer", date: i)));
          }

          break;
        }
      }

      for(final i in herbDates){
        if(DateFormat('dd-MM-yyyy').parse(i).isAfter(DateTime.now().subtract(const Duration(days: 1)))){
          if(DateFormat('dd-MM-yyyy').parse(i).isAtSameMomentAs(DateTime(now.year,now.month,now.day))){
            notificationWidgets.insert(0,NotificationTile(notification: Notify(cropName: data['name'], activity: "Herbicides", date: i)));
          }else{
            notificationWidgets.add(NotificationTile(notification: Notify(cropName: data['name'], activity: "Herbicides", date: i)));
          }

          break;
        }
      }
    }

    if(cropWidget.isEmpty){
      cropWidget.add(const AddCropCard());
    }

  }
}

