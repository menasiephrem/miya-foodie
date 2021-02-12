
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodie/components/Inputs/input_detail.dart';
import 'package:foodie/components/Inputs/input_text_area.dart';
import 'package:foodie/components/Inputs/number_imput.dart';
import 'package:foodie/models/recipe.dart';
import 'package:foodie/services/recipe_services.dart';


import '../finder.dart';

class EditRecipe extends StatefulWidget {
  EditRecipe(this.recipe);
  final Recipe recipe;
  @override
  _EditRecipeState createState() => _EditRecipeState();
}

class _EditRecipeState extends State<EditRecipe> {
  RecipeService _recipeService = locator<RecipeService>();
  bool loading = false;
  Recipe _recipe;


  @override
  void initState() { 
    super.initState();
    setState(() {
      _recipe = this.widget.recipe;
    });
  }



  void _editRecipe() async {
    await _recipeService.updateRecipeDraft(_recipe);
    Navigator.of(context).pop(_recipe);
  }

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
                                  "Edit\n${this.widget.recipe.name}",
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
                              _recipe.name = name
                            }, "Edit Name*", value: _recipe.name,),
                            SizedBox(height: 10),
                            InputForm((description) => {
                              _recipe.description = description
                            }, "Edit Short Description*", value: _recipe.description),
                            SizedBox(height: 10),
                            NumberInput((serving) => {
                              _recipe.serving = serving
                            }, "Edit Serving*", value: _recipe.serving),
                            SizedBox(height: 10),
                            NumberInput((prepareTime) => {
                              _recipe.prepareTime = prepareTime
                            }, "Edit prepare time (min)*", value: _recipe.prepareTime),
                            SizedBox(height: 10),
                            NumberInput((cookingTime) => {
                              _recipe.cookingTime = cookingTime
                            }, "Edit cooking time (min)*", value: _recipe.cookingTime),
                            SizedBox(height: 10),
                            InputTextArea((note) => {
                              _recipe.note = note
                            }, "Edit note", value: _recipe.note),
                            SizedBox(height: 10),
                            !loading ?
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.brown[300])),
                              onPressed: () {
                                _editRecipe();
                              },
                              color: Color(0xffa59671),
                              textColor: Colors.white,
                              child: Container(
                                width: MediaQuery.of(context).size.width - 200,
                                height: 40,
                                alignment: Alignment.center,
                                child: Text("Update Recipe", style: TextStyle(fontSize: 14)),
                              ),
                            ): CircularProgressIndicator()
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