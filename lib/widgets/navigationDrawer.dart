import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:harbour_app/Homepage.dart';
import 'package:harbour_app/Start.dart';
import 'package:harbour_app/monitorAnalyse.dart';
import 'package:harbour_app/resetScreen.dart';
import 'package:harbour_app/userPage.dart';

class NavigationDrawerWidget extends StatefulWidget {
  @override
  _NavigationDrawerWidgetState createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;
  String usertype = "User";
  String name = "user";
  String email = "test@gmail.com";
  String profileUrl = "https://bit.ly/3eJFEYV";

  List<String> adminMails = [
    "abhi.jha.cs@gmail.com",
    "shivam@gmail.com",
    "shubham@gmail.com",
    "dhairya@gmail.com",
    "yashpatel@gmail.com",
    "yashshah@gmail.com",
  ];

  getUser() async {
    User? firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;
    setState(() {
      this.user = firebaseUser!;
      this.name = user.displayName!;
      this.email = user.email!;
      this.profileUrl = user.photoURL!;
    });

    for (String adminMail in adminMails) {
      if (adminMail == email) {
        usertype = "Admin";
      }
    }
  }

  signOut() async {
    _auth.signOut();

    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Start()));
  }

  @override
  void initState() {
    super.initState();
    this.getUser();
  }

  final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Color.fromRGBO(16, 48, 82, 1),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                margin: EdgeInsets.zero,
                accountName: Text(name),
                accountEmail: Text(email),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(profileUrl),
                ),
              ),
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  buildMenuItem(
                    text: 'Role: $usertype',
                    icon: Icons.people_outlined,
                    onClicked: () {},
                  ),
                  const SizedBox(height: 12),
                  buildMenuItem(
                    text: 'Home',
                    icon: Icons.account_balance_outlined,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 12),
                  buildMenuItem(
                    text: 'My Profile',
                    icon: Icons.account_circle_outlined,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 12),
                  buildMenuItem(
                    text: 'Monitor & Analyse',
                    icon: Icons.security_outlined,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  const SizedBox(height: 12),
                  buildMenuItem(
                    text: 'Change Password',
                    icon: Icons.settings_outlined,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  const SizedBox(height: 12),
                  buildMenuItem(
                    text: 'Sign Out',
                    icon: Icons.logout_outlined,
                    onClicked: () => selectedItem(context, 4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final iconColor = Color.fromRGBO(185, 193, 201, 1);
    final hoverColor = Colors.white;

    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => UserPage(
            username: name,
            useremail: email,
            picUrl: profileUrl,
          ),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MonitorAnalyse(),
        ));
        break;
      case 3:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ResetScreen()));
        break;
      case 4:
        signOut();
        break;
    }
  }
}
