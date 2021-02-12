import 'package:flutter/material.dart';


class InputTextArea extends StatelessWidget {
  InputTextArea(this.onSubmit, this.hint, {this.value = "", this.lines = 4});
  final Function onSubmit;
  final String hint;
  final String value;
  final int lines;
  @override
  Widget build(BuildContext context) {

  TextEditingController  _getControler(String text){
     if(text == ""){
       return null;
     }
    var contorler = new TextEditingController(text: text);
    contorler.selection = TextSelection.fromPosition(TextPosition(offset: text.length));
    return contorler;
  }
    return TextField(
          obscureText: false,
          style: style,
          maxLines: lines,
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
