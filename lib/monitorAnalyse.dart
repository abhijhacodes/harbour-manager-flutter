import 'package:flutter/material.dart';
import 'package:harbour_app/widgets/navigationDrawer.dart';

class MonitorAnalyse extends StatefulWidget {
  const MonitorAnalyse({Key? key}) : super(key: key);

  @override
  _MonitorAnalyseState createState() => _MonitorAnalyseState();
}

class _MonitorAnalyseState extends State<MonitorAnalyse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text("Monitor and Analyse"),
          centerTitle: true,
        ));
  }
}
