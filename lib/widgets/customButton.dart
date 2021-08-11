import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final void Function() onTapFunction;

  CustomButton({required this.buttonText, required this.onTapFunction});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(buttonText),
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.white,
        primary: Colors.blueGrey[800],
        onSurface: Colors.grey,
        side: BorderSide(color: Colors.blueGrey, width: 1),
        elevation: 10,
        minimumSize: Size(100, 38),
        shadowColor: Colors.teal,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      onPressed: onTapFunction,
    );
  }
}
