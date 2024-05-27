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

  static Future<void> verifyPhoneNumber(String number,Function onCodeSent,Function onError)async{
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (PhoneAuthCredential credential){},
        verificationFailed: (FirebaseAuthException e){onError();},
        codeSent: (String verificationId, int? resendToken){onCodeSent(verificationId);},
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

  static Future<void> registerUser(String email,String password)async{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    // FirebaseBackend.signInWithEmailAndPassword(email, password);

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

  static Future<bool> checkIfEmailIsVerified()async{
    final user = FirebaseAuth.instance.currentUser;

    if(user != null) {
      user.reload();
      return user.emailVerified;
    }else{
      return false;
    }

  }
}