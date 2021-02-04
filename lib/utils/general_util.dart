import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String message,bool error){
    Fluttertoast.showToast(
      msg: '$message',
       toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: error? Colors.red: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
}


Future<bool> isUserLoggedIn() async{
  String userName = await FlutterSession().get("userName");
  return userName != null;
}

Future<bool> getLoggedInUser() async{
  if(await isUserLoggedIn()){
    return await FlutterSession().get("userName");
  }
  return null;
}