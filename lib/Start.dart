import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:harbour_app/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:harbour_app/Signup.dart';
import 'package:harbour_app/widgets/customButton.dart';

class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> googleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        final UserCredential user =
            await _auth.signInWithCredential(credential);

        await Navigator.pushReplacementNamed(context, "/");

        return user;
      } else {
        throw StateError('Missing Google Auth Token');
      }
    } else
      throw StateError('Sign in Aborted');
  }

  navigateToLogin() async {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
  }

  navigateToRegister() async {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => SignUp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.cyan[50],
        child: Column(
          children: <Widget>[
            SizedBox(height: 35.0),
            Container(
              height: 350,
              width: 290,
              child: SvgPicture.asset('images/ship1.svg'),
            ),
            RichText(
                text: TextSpan(
                    text: 'Welcome to ',
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    children: <TextSpan>[
                  TextSpan(
                      text: 'Harbour',
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange))
                ])),
            SizedBox(height: 10.0),
            Text(
              'Harbour Management app by TechFreaks',
              style: TextStyle(color: Colors.blue[900]),
            ),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomButton(
                    buttonText: "LOGIN", onTapFunction: navigateToLogin),
                SizedBox(width: 20.0),
                CustomButton(
                    buttonText: "REGISTER", onTapFunction: navigateToRegister)
              ],
            ),
            SizedBox(height: 20.0),
            SignInButton(
              Buttons.Google,
              text: "Continue with Google",
              onPressed: googleSignIn,
              elevation: 10,
              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.all(Radius.circular(30))),
            )
          ],
        ),
      ),
    );
  }
}
