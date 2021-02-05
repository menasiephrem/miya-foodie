import 'package:flutter/material.dart';


class InputTextArea extends StatelessWidget {
  InputTextArea(this.onSubmit, this.hint);
  final Function onSubmit;
  final String hint;
  @override
  Widget build(BuildContext context) {
    return TextField(
          obscureText: false,
          style: style,
          maxLines: 4,
          onChanged: this.onSubmit,
           decoration: InputDecoration(
            hintText: this.hint,
            hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 18)
        ),
      );
  }
}

TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
