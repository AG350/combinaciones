import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  final String text;
  final Colors? color;
  final Function()? onPress;

  const FormButton({
    required this.text,
    this.color,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: MediaQuery.of(context).size.height * 0.055,
      color: Colors.blueAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Text(text),
      onPressed: onPress,
    );
  }
}
