import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodie/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  return userName != null && userName != "";
}

Future<bool> getLoggedInUser() async{
  if(await isUserLoggedIn()){
    return await FlutterSession().get("userName");
  }
  return null;
}

Future<void> loadSession() async {
    var prefs = await SharedPreferences.getInstance();
    await FlutterSession().set("userName", "");
    String userData = prefs.get("user");
    if(userData != null){
      User user = User.fromData(jsonDecode(userData));
      await FlutterSession().set("userName", user.userName);
    }
}