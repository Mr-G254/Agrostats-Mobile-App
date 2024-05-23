import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

abstract class FirebaseBackend{
  static bool isSignedIn = false;

  static Future<void> initialize()async{
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    isSignedIn = !(FirebaseAuth.instance.currentUser == null);
  }

  static User? getCurrentUser(){
    return FirebaseAuth.instance.currentUser;
  }

  static Future<void> createUser(String Email,String Password)async{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: Email, password: Password);
  }

  static Future<void> verifyPhoneNumber(String number,Function onErrorCallback,Function onCodeSent)async{
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (PhoneAuthCredential credential)async{ await FirebaseBackend.signInUsingCredential(credential);},
        verificationFailed: (FirebaseAuthException e){onErrorCallback(e);},
        codeSent: (String verificationId, int? resendToken){onCodeSent(verificationId);},
        codeAutoRetrievalTimeout: (String verificationId){}
    );
  }

  static Future<PhoneAuthCredential> confirmPhoneNumberVerified(String verId,String code)async{
    final cred = PhoneAuthProvider.credential(verificationId: verId, smsCode: code);
    return cred;
  }

  static Future<void> signInUsingCredential(PhoneAuthCredential cred)async{
    await FirebaseAuth.instance.signInWithCredential(cred);
  }
}