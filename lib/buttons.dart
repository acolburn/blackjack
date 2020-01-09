import 'package:flutter/material.dart';

class MyButton extends MaterialButton {
  MyButton(
      {@required this.buttonText,
      @required this.buttonColor,
      @required this.onPress});

  final Function onPress;
  final String buttonText;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 5,
      color: buttonColor,
//      borderRadius: BorderRadius.circular(50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      onPressed: onPress,
      height: 100,
      minWidth: 100,
      child: Text(
        buttonText,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
