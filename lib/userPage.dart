import 'package:flutter/material.dart';
import 'package:harbour_app/widgets/navigationDrawer.dart';

class UserPage extends StatelessWidget {
  final String username;
  final String useremail;
  final String picUrl;

  UserPage(
      {required this.username, required this.useremail, required this.picUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text("User Profile"),
        centerTitle: true,
      ),
    );
  }
}
