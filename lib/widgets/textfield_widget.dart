import 'package:flutter/material.dart';

class TextfieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final String? hintText;
  final Widget? icono;
  final Function(String)? onChanged;

  const TextfieldWidget({this.controller, required this.labelText, this.hintText, this.icono, this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: this.controller,
        decoration: InputDecoration(
            prefix: this.icono,
            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white.withOpacity(0.3))),
            labelText: this.labelText,
            hintText: this.hintText),
        onChanged: onChanged,
      ),
    );
  }
}
