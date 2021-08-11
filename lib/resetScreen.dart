import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:harbour_app/Login.dart';
import 'package:harbour_app/widgets/customButton.dart';
import 'package:harbour_app/widgets/gestureNavigator.dart';

class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  late String _email;
  final auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  sendReset() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        auth.sendPasswordResetEmail(email: _email);
        Fluttertoast.showToast(
            msg: "Password reset Email sent to $_email",
            backgroundColor: Colors.blue[300],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP);
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
      } on FirebaseAuthException catch (error) {
        Fluttertoast.showToast(
            msg: error.message!,
            backgroundColor: Colors.blue[300],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP);
      }
    }
  }

  navigateToLogin() async {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      body: Column(
        children: <Widget>[
          SizedBox(height: 55.0),
          Container(
            height: 280,
            width: 260,
            child: SvgPicture.asset('images/emailsent.svg'),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
            child: Form(
              key: _formKey,
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
                    _email = input.trim();
                  }),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButton(
                  buttonText: "Send request", onTapFunction: sendReset),
            ],
          ),
          SizedBox(height: 15),
          GestureNavigator(
              navText: "Go back to login", onTapFunction: navigateToLogin),
        ],
      ),
    );
  }
}
