import 'package:flutter/material.dart';


class InputForm extends StatelessWidget {
  InputForm(this.onSubmit, this.hint, {this.value = ""});
  final Function onSubmit;
  final String hint;
  final String value;
  @override
  Widget build(BuildContext context) {
   
   TextEditingController  _getControler(String text){
      var contorler = new TextEditingController(text: text);
      contorler.selection = TextSelection.fromPosition(TextPosition(offset: text.length));
      return contorler;
    }
    return TextField(
          obscureText: false,
          style: style,
          controller: _getControler(this.value),
          onChanged: this.onSubmit,
           decoration: InputDecoration(
            hintText: this.hint,
            labelText: this.hint,
            hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 18)
        ),
      );
  }
}

TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
