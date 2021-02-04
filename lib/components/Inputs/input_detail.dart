import 'package:flutter/material.dart';


class InputForm extends StatelessWidget {
  InputForm(this.onSubmit, this.hint);
  final Function onSubmit;
  final String hint;
  @override
  Widget build(BuildContext context) {
    return TextField(
          obscureText: false,
          style: style,
          onChanged: this.onSubmit,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
              hintText: "$hint",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
          );
  }
}

TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
