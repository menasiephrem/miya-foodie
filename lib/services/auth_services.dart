import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  Future<User> loginUser(String phone, String password, bool rememeber) async{
      var res = await _fireStore.collection("users").doc(phone).get();
      
      if(res.exists){
       if(res.data()['password'] == password){
         User loggedIn = new User.fromData(res.data());
         if(rememeber){
            var prefs = await SharedPreferences.getInstance();
            String userString =  jsonEncode(loggedIn);
            prefs.setString("user", userString);
         }
         return loggedIn;
       }
      }
      return null;
  }

}