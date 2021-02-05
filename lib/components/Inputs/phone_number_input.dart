import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PhoneNumberInput extends StatelessWidget {
  PhoneNumberInput(this.onSubmit);
  Function onSubmit;
  @override
  Widget build(BuildContext context) {
    return TextField(
        obscureText: false,
        style: style,
        onChanged: this.onSubmit,
        decoration: InputDecoration(
            hintText: "User Name",
            hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18)
        ),
      );
  }
}

TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.black);
