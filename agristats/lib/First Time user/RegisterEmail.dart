import 'package:agristats/First%20Time%20user/VerifyEmail.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../Backend/FirebaseBackend.dart';
import '../Common/Components.dart';

class RegisterEmail extends StatefulWidget{
  const RegisterEmail({super.key});

  @override
  State<RegisterEmail> createState() => _RegisterEmailState();
}

class _RegisterEmailState extends State<RegisterEmail>{
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirm = TextEditingController();

  bool _isChecked = false;
  static bool _isHidden = true;
  static bool _isHidden2 = true;
  bool _showError = false;
  bool shortPassword = false;
  bool visible = false;
  bool emailShowError = false;
  bool loading  = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    password.addListener(_checkIfPasswordsMatch);
    confirm.addListener(_checkIfPasswordsMatch);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    name.dispose();
    email.dispose();
    password.dispose();
    confirm.dispose();
    super.dispose();
  }

  void showError(String error){
    showDialog(context: context, builder: (context) => DialogEr(infoType: "Error", info: error));
  }

  void showErrorObj(Object){
    showDialog(context: context, builder: (context) => DialogEr(infoType: "Error", info: Object.toString()));
    setState(() {
      loading = false;
    });
  }

  Future<void> verifyEmail()async{
    await FirebaseBackend.verifyEmail(goToVerificationPage).catchError(showErrorObj);
  }

  Future<void> setUpAccountwithEmailAndPassword()async{
    await FirebaseBackend.registerUser(name.text,email.text, password.text,verifyEmail,showErrorObj).catchError(showErrorObj);

  }

  void goToVerificationPage(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyEmail(email: email.text)));
  }


  void _checkIfPasswordsMatch(){
    if(confirm.text.isNotEmpty && password.text.isNotEmpty) {
      setState(() {
        if (confirm.text == password.text) {
          _showError = false;
        } else {
          _showError = true;
        }
      });
    }
  }

  void startRegistrationProcess()async{
    if(name.text.isEmpty||email.text.isEmpty||password.text.isEmpty||confirm.text.isEmpty){
      setState(() {
        visible = true;
      });
    }else{
      setState(() {
        visible = false;
      });

      final emailIsValid = EmailValidator.validate(email.text);
      if (!emailIsValid) {
        setState(() {
          emailShowError = true;
        });
      } else {
        setState(() {
          emailShowError = false;
        });

        if (password.text.length < 6) {
          setState(() {
            shortPassword = true;
          });
        } else {
          setState(() {
            shortPassword = false;
          });

          setState(() {
            loading = true;
          });

          try {
            await setUpAccountwithEmailAndPassword();


          } catch (e) {
            showError(e.toString());

            setState(() {
              loading = false;
            });
          }
        }
      }
    }
  }

  final regText = const Text(
    "Register",
    style: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontFamily: "Times"
    ),
  );

  final loadingAnimation = LoadingAnimationWidget.threeArchedCircle(
      color: Colors.white,
      size: 30
  );

  void changeVisibility(){
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void changeVisibility2(){
    setState(() {
      _isHidden2 = !_isHidden2;
    });
  }

  @override
  Widget build(BuildContext context){
    var view = IconButton(
        onPressed: (){
          setState(() {
            _isHidden = !_isHidden;
          });
        },
        icon: _isHidden ? const Icon(Icons.visibility_outlined,color: Colors.white,) : const Icon(Icons.visibility_off_outlined,color: Colors.white,)
    );

    var view2 = IconButton(
        onPressed: (){
          setState(() {
            _isHidden2 = !_isHidden2;
          });
        },
        icon: _isHidden2 ? const Icon(Icons.visibility_outlined,color: Colors.white,) : const Icon(Icons.visibility_off_outlined,color: Colors.white,)
    );

    return Column(
      children: [
        Visibility(
          visible: visible,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: Container(
            color: Colors.transparent,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline_rounded,size: 20,color: Colors.red,),
                SizedBox(width: 10,),
                Text(
                  "Ensure that all field are filled",
                  style: TextStyle(
                      color: Colors.red,
                      fontFamily: "Times",
                      fontSize: 10,
                      fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
        ),
        Input(label: "NAME", editor: name, type: TextInputType.text,action: TextInputAction.next),
        Input(label: "EMAIL", editor: email, type: TextInputType.emailAddress,action: TextInputAction.next,errorTxt: "Invalid Email",showError: emailShowError,),
        Input(label: "PASSWORD", editor: password, type: TextInputType.visiblePassword,action: TextInputAction.next,hideText: _isHidden,errorTxt: "The password must at least have 6 characters",showError: shortPassword,icon: view,),
        Input(label: "CONFIRM", editor: confirm, type: TextInputType.visiblePassword,action: TextInputAction.done,hideText: _isHidden2,errorTxt: "The passwords don't match",showError: _showError,icon: view2,),
        // Container(
        //     padding: const EdgeInsets.only(left: 10),
        //     height: 40,
        //     // alignment: Alignment.centerLeft,
        //     child: CheckboxListTile(
        //       title: const Text(
        //         "Show password",
        //         style: TextStyle(
        //             fontSize: 12,
        //             color: Colors.white,
        //             fontFamily: "Times"
        //         ),
        //       ),
        //       value: _isChecked,
        //       onChanged: (bool? val){
        //         if(val != null){
        //           setState(() {
        //             _isChecked = val;
        //             _isHidden = !val;
        //           });
        //         }
        //       },
        //       controlAffinity: ListTileControlAffinity.leading,
        //       activeColor: const Color(0xff374804),
        //     )
        // ),
        Container(
          padding: const EdgeInsets.only(top: 15,bottom: 15,right: 80,left: 80),
          width: double.infinity,
          height: 75,
          child: ElevatedButton(
              onPressed: (){
                startRegistrationProcess();
              },
              style: ElevatedButton.styleFrom(
                elevation: 10,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                backgroundColor: const Color(0xff374804),
              ),
              child: loading? loadingAnimation : regText
          ),
        ),
      ],
    );
  }

}

