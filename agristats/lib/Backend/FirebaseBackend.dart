import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

abstract class FirebaseBackend{
  static bool isSignedIn = false;
  static String userName = "";
  static String userEmail = "";
  static String userPhone = "";

  static Future<void> initialize()async{
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    isSignedIn = !(FirebaseAuth.instance.currentUser == null);
  }

  static User? getCurrentUser(){
    return FirebaseAuth.instance.currentUser;
  }

  static Future<void> verifyPhoneNumber(String name,String number,Function onCodeSent,Function onError)async{
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (PhoneAuthCredential credential){
        },
        verificationFailed: (FirebaseAuthException e){onError();},
        codeSent: (String verificationId, int? resendToken){
          onCodeSent(verificationId);
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
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) => FirebaseBackend.addUserToDb(name, email, "", onCompletion, onError)).catchError(onError);

  }

  static Future<void> signInWithEmailAndPassword(String email,String password,Function onCompletion,Function onError)async{
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) => onCompletion()).catchError(onError);

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
    final users = FirebaseFirestore.instance.collection('users');

    if (phone.isEmpty){
      final user = <String,dynamic>{
        "iud" : FirebaseAuth.instance.currentUser?.uid ?? "",
        "name" : name,
        "email" : email,
        "phone" : phone,
      };

      await users.add(user).then((value) => onCompletion()).catchError(onError);

    }else{
      QuerySnapshot querySnapshot = await users.where("phone", isEqualTo: phone).get();

      if(querySnapshot.docs.isEmpty){
        final user = <String,dynamic>{
          "iud" : FirebaseAuth.instance.currentUser?.uid ?? "",
          "name" : name,
          "email" : email,
          "phone" : phone,
        };

        await users.add(user).then((value) => onCompletion()).catchError(onError);
      }
    }

  }

  static Future<String> getUserName()async{
    userEmail = FirebaseAuth.instance.currentUser!.email!;
    userPhone = FirebaseAuth.instance.currentUser!.phoneNumber!;

   QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection("users").where("iud",isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
   final data  = snapshot.docs;

   if(data.isNotEmpty){
     String? name = data[0]["name"] as String?;
     userName = name!;
      return name ?? "";
   }else{
     return "";
   }
  }
}