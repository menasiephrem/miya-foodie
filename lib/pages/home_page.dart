import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodie/pages/main_page.dart';

class HomePage extends StatelessWidget {
  const HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/pic1.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
          child: 
           Container(
            width: MediaQuery.of(context).size.width, 
            padding: EdgeInsets.symmetric(vertical: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Good Food",
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "Deliciously Simple.",
                      style: TextStyle(fontSize: 13),
                    )
                  ],
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.brown[300])),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage())
                    );
                  },
                  color: Color(0xffa59671),
                  textColor: Colors.white,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 200,
                    height: 40,
                    alignment: Alignment.center,
                    child: Text("Start Cooking", style: TextStyle(fontSize: 14)),
                  ),
                )
              ],
            ),
          ) /* add child content here */,
        )
      ),
    );
  }
}
