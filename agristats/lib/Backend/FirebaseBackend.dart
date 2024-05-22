import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import 'firebase_options.dart';

abstract class FirebaseBackend{
  static bool isSignedIn = false;

  static Future<void> initialize()async{
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    isSignedIn = !(FirebaseAuth.instance.currentUser == null);
  }

  static Future<void> createUser(String Email,String Password)async{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: Email, password: Password);
  }
}