import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodie/components/Inputs/password_input.dart';
import 'package:foodie/components/Inputs/phone_number_input.dart';

class LoginPage extends StatefulWidget {
  LoginPage();

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

   String _password = "tes";
   String _phone;
   bool _rememeberUser = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light, 
        child: Container(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width, 
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/login.jpg"),
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.17), BlendMode.srcOver),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50,),
                      InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          children: [
                            Icon(Icons.arrow_back_ios, color: Colors.white, ),
                            SizedBox(width: 5),
                            Text("Back", style: TextStyle(color: Colors.white, fontSize: 20),)
                          ],
                        )
                      ),
                    ],
                  ),
                ),
              ), 
              Container(
                width: MediaQuery.of(context).size.width - 70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 35,),
                    Text(
                      "Welcome back to\nFoodie",
                      style: TextStyle(color: Color(0xffa59671), fontSize: 30, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 45.0),
                    PhoneNumberInput((phone){
                      setState(() {
                        _phone = phone;
                      });
                    }),
                    SizedBox(height: 25.0),
                    PasswordField((password){
                      setState(() {
                        _password = password;
                      });
                    }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Remember", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),),
                        Transform.scale(
                          scale: .8,
                          child: CupertinoSwitch(
                            value: _rememeberUser,
                            onChanged: (value){
                              setState(() {
                                _rememeberUser = value;
                              });
                            },
                            activeColor: Color(0xffa59671),
                          )
                        ), 
                        Spacer(),
                        Text("Forgot?", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),)
                      ],
                    ),
                    SizedBox(
                      height: 35.0,
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.brown[300])),
                      onPressed: () {
                        print("Login");
                      },
                      color: Color(0xffa59671),
                      textColor: Colors.white,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 100,
                        height: 40,
                        alignment: Alignment.center,
                        child: Text("Log in", style: TextStyle(fontSize: 14)),
                      ),
                    )
                  ],
                ),
              ),
            ]
          ),
        )
      )
    );
  }
}