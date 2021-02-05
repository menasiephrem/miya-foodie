import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodie/components/Inputs/input_detail.dart';
import 'package:foodie/components/Inputs/input_text_area.dart';
import 'package:foodie/components/Inputs/number_imput.dart';

class AddRecipe extends StatefulWidget {
  AddRecipe(this.userName, this.catgory);
  final String userName;
  final String catgory;
  @override
  _AddRecipeState createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light, 
        child: Stack(
          children: [
            Container(
              color: Colors.black12,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    'assets/images/wave_top.svg',
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                  ),
                  SvgPicture.asset(
                    'assets/images/blob.svg',
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                  ),
                  
                  SvgPicture.asset(
                    'assets/images/wave_bottom.svg',
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                  )
                ],
              )
            ),
            Center(
              child: new ClipRect(
                child: new BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: new Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: MediaQuery.of(context).size.height - 175,
                    decoration: new BoxDecoration(
                      color: Colors.grey.shade100.withOpacity(0.5),
                    ),
                    child: new Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Add\n${this.widget.catgory}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.brown[400],
                                    fontSize:30,
                                  ), 
                                ), 
                                RawMaterialButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  elevation: 2.0,
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.brown,
                                    size: 35.0,
                                  ),
                                  padding: EdgeInsets.all(15.0),
                                  shape: CircleBorder(),
                                )
                              ],
                            ),
                            SizedBox(height: 30),
                            InputForm((name) => {

                            }, "Add Recipe Name*"),
                            SizedBox(height: 10),
                            InputForm((name) => {

                            }, "Add Short Description*"),
                            SizedBox(height: 10),
                            NumberInput((name) => {

                            }, "Add Serving*"),
                            SizedBox(height: 10),
                            NumberInput((name) => {

                            }, "Add prepare time (min)*"),
                            SizedBox(height: 10),
                            NumberInput((name) => {

                            }, "Add cooking time (min)*"),
                            SizedBox(height: 10),
                            InputTextArea((name) => {

                            }, "Add note"),
                            SizedBox(height: 10),
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.brown[300])),
                              onPressed: () {
                              },
                              color: Color(0xffa59671),
                              textColor: Colors.white,
                              child: Container(
                                width: MediaQuery.of(context).size.width - 200,
                                height: 40,
                                alignment: Alignment.center,
                                child: Text("Add Recipe", style: TextStyle(fontSize: 14)),
                              ),
                            )
                          ],
                        ),
                      )
                    ),
                  ),
                ),
              )
            )
          ],
        )
      )
    );
  }
}