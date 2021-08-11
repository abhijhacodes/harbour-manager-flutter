import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:harbour_app/Homepage.dart';
import 'package:harbour_app/Start.dart';
import 'package:harbour_app/resetScreen.dart';
import 'package:harbour_app/widgets/customButton.dart';
import 'package:harbour_app/widgets/gestureNavigator.dart';
import 'Signup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String _email, _password;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user!.emailVerified) {
        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
  }

  login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        final user = await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);

        if (user.user!.emailVerified) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage()));
        }
      } on FirebaseAuthException catch (error) {
        Fluttertoast.showToast(
            msg: error.message!,
            backgroundColor: Colors.blue[300],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP);
      }
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  navigateToSignUp() async {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => SignUp()));
  }

  navigateToReset() async {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ResetScreen()));
  }

  navigateToStart() async {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Start()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan[50],
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 55.0),
                Container(
                  height: 300,
                  width: 280,
                  child: SvgPicture.asset('images/authentication.svg'),
                  // child: Image.asset('images/login.jpg'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 32.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: TextFormField(
                              validator: (input) {
                                if (input!.isEmpty) return 'Enter Email';
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  labelText: 'Email',
                                  hintText: 'Enter your email',
                                  prefixIcon: Icon(Icons.email)),
                              onChanged: (input) {
                                _email = input;
                              }),
                        ),
                        Container(
                          child: TextFormField(
                              validator: (input) {
                                if (input!.length < 6)
                                  return 'Password length should be minimum 6';
                              },
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: 'Enter your password',
                                prefixIcon: Icon(Icons.lock),
                              ),
                              obscureText: true,
                              onChanged: (input) {
                                _password = input;
                              }),
                        ),
                        SizedBox(height: 30),
                        CustomButton(buttonText: "LOGIN", onTapFunction: login),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                GestureNavigator(
                  navText: "Forgot password?",
                  onTapFunction: navigateToReset,
                ),
                SizedBox(height: 5),
                GestureNavigator(
                  navText: "Go back to home",
                  onTapFunction: navigateToStart,
                )
              ],
            ),
          ),
        ));
  }
}
