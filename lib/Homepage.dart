import 'package:harbour_app/Start.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:harbour_app/widgets/navigationDrawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;
  bool isloggedin = false;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (!user!.emailVerified) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Start()));
      }
    });
  }

  getUser() async {
    User? firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser!.emailVerified) {
      setState(() {
        this.user = firebaseUser!;
        this.isloggedin = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return !isloggedin
        ? Start()
        : Scaffold(
            drawer: NavigationDrawerWidget(),
            appBar: AppBar(
              title: Text("HomePage"),
              centerTitle: true,
            ),
          );
  }
}
