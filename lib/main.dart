import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:harbour_app/Start.dart';
import 'package:harbour_app/Homepage.dart';
import 'package:harbour_app/Login.dart';
import 'package:harbour_app/Signup.dart';
import 'package:harbour_app/VerifyScreen.dart';
import 'package:google_fonts/google_fonts.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Color.fromRGBO(26, 70, 117, 1),
          textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).textTheme,
          )),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        "Login": (BuildContext context) => Login(),
        "SignUp": (BuildContext context) => SignUp(),
        "Start": (BuildContext context) => Start(),
        "VerifyScreen": (BuildContext context) => VerifyScreen(),
      },
    );
  }
}
