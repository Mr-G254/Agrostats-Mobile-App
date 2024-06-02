import 'dart:ffi';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'firebase_options.dart';

abstract class FirebaseBackend{
  static bool isSignedIn = false;
  static String userName = "";
  static String userEmail = "";
  static String userPhone = "";
  static String profilePhotoUrl = "";

  static Future<void> initialize()async{
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    if(FirebaseAuth.instance.currentUser != null){
      isSignedIn = true;
      await FirebaseBackend.getProfile();
    }

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
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
      FirebaseBackend.getProfile();
      onCompletion();
    }).catchError(onError);

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

    await userDb.set(farm).then((value) => onCompletion()).catchError(onError);

  }
}

