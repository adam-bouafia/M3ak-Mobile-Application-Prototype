import 'package:firebase_auth/firebase_auth.dart';
import 'package:Dhayen/login/reusable_widgets/reusable_widget.dart';
import 'package:Dhayen/login/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:Dhayen/Login/utils/terms_of_use.dart';
import '../../Dashboard/Splash/Splash.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "inscri".tr,
          style: TextStyle(fontFamily: 'Montserrat',fontSize: 24,color:  Color(0xff122136), fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            hexStringToColor("f8eae1"),
            hexStringToColor("f8eae1"),
            hexStringToColor("f8eae1")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("E-mail", Icons.person_outline, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Mot de passe", Icons.lock_outlined, true,
                    _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                firebaseUIButton(context, "S'inscrire", () {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    print("Nouveau compte créé");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Splash()));
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                }),
                const SizedBox(height: 20,),
                TermsOfUse(),
              ],
            ),
          ))),
    );
  }
}
