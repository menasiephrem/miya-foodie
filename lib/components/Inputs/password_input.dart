import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PasswordField extends StatelessWidget {
  PasswordField(this.onSubmit);
  Function onSubmit;
  @override
  Widget build(BuildContext context) {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
    return TextField(
      obscureText: true,
      style: style,
      onChanged: this.onSubmit,
       decoration: InputDecoration(
            hintText: "Password",
            hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18)
        ),
      );
  }
}


