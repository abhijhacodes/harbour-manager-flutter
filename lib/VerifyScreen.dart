import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:harbour_app/Homepage.dart';
import 'package:harbour_app/Start.dart';
import 'package:harbour_app/widgets/gestureNavigator.dart';

class VerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;

  @override
  void initState() {
    user = auth.currentUser!;
    user.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  navigateToStart() async {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Start()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 55.0),
              Container(
                height: 280,
                width: 260,
                child: SvgPicture.asset('images/emailsent.svg'),
              ),
              SizedBox(height: 55.0),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0),
                child: Column(
                  // mainAxisAlignment:,
                  children: [
                    Container(
                      child: Text("An email has been sent to ${user.email}",
                          style: TextStyle(
                              color: Colors.blue[500],
                              fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      child: Text("Please verify to complete registration!",
                          style: TextStyle(
                              color: Colors.blue[500],
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 20),
                    GestureNavigator(
                        navText: "Go back to home",
                        onTapFunction: navigateToStart),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    }
  }
}
