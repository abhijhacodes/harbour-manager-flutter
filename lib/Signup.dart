import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:harbour_app/Login.dart';
import 'package:harbour_app/VerifyScreen.dart';
import 'package:harbour_app/widgets/customButton.dart';
import 'package:harbour_app/widgets/gestureNavigator.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String _username, _email, _password;

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) async {
      if (user!.emailVerified) {
        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }

  signUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => VerifyScreen()));
        // ignore: unnecessary_null_comparison
        if (user != null) {
          await _auth.currentUser!.updateDisplayName(_username);
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
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  navigateToLogin() async {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
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
                  height: 280,
                  width: 260,
                  child: SvgPicture.asset('images/signup.svg'),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 32.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: TextFormField(
                                validator: (input) {
                                  if (input!.isEmpty)
                                    return 'Username cannot be empty';
                                },
                                decoration: InputDecoration(
                                  labelText: 'Username',
                                  prefixIcon: Icon(Icons.person),
                                  hintText: 'Enter your username',
                                ),
                                onChanged: (input) {
                                  _username = input;
                                }),
                          ),
                          Container(
                            child: TextFormField(
                                validator: (input) {
                                  if (input!.isEmpty)
                                    return 'Email cannot be empty';
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  prefixIcon: Icon(Icons.email),
                                  hintText: 'Enter your email',
                                ),
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
                                  prefixIcon: Icon(Icons.lock),
                                  hintText: 'Enter your password',
                                ),
                                obscureText: true,
                                onChanged: (input) {
                                  _password = input;
                                }),
                          ),
                          SizedBox(height: 20),
                          CustomButton(
                              buttonText: "REGISTER", onTapFunction: signUp),
                          SizedBox(height: 15),
                          GestureNavigator(
                              navText: "Go back to login",
                              onTapFunction: navigateToLogin),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
