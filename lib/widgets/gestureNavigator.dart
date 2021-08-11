import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GestureNavigator extends StatelessWidget {
  final String navText;
  final void Function() onTapFunction;

  GestureNavigator({required this.navText, required this.onTapFunction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(navText, style: TextStyle(color: Colors.grey[500])),
      onTap: onTapFunction,
    );
  }
}
