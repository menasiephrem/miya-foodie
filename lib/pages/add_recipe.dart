import 'dart:io';
import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodie/components/Inputs/input_detail.dart';
import 'package:foodie/components/Inputs/input_text_area.dart';
import 'package:foodie/components/Inputs/number_imput.dart';
import 'package:foodie/models/recipe.dart';
import 'package:foodie/services/recipe_services.dart';
import 'package:foodie/utils/general_util.dart';
import 'package:image_picker/image_picker.dart';

import '../finder.dart';

class AddRecipe extends StatefulWidget {
  AddRecipe(this.user, this.catgory);
  final String user;
  final String catgory;
  @override
  _AddRecipeState createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  RecipeService _recipeService = locator<RecipeService>();
  final picker = ImagePicker(); 
  bool picLoaded = false;
  bool loadingPic = false;
  Recipe _recipe;


  @override
  void initState() { 
    super.initState();
    setState(() {
      _recipe = Recipe.init(this.widget.user, this.widget.catgory);
    });
  }

  Future uploadFile(File _image) async {   
    setState(() {
      loadingPic = true;
    });  
    Reference storageReference = FirebaseStorage.instance    
        .ref()    
        .child('foodPics/${DateTime.now().microsecondsSinceEpoch}');    
    UploadTask uploadTask = storageReference.putFile(_image);    
    await uploadTask;    
    print('File Uploaded');    
    storageReference.getDownloadURL().then((fileURL) { 
      _recipe.img = fileURL;
      _saveRecipe();
    });    
  } 

  void _saveRecipe() async {
    await _recipeService.createRecipe(_recipe);
    Navigator.of(context).pop();
  }

  void _showPicker(contextcontext) async{
    if(_recipe.isEmpty()){
      showToast("Fill in all fileds", true);
      return;
    }
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () async {
                      final pickedFile = await picker.getImage(source: ImageSource.gallery, maxHeight:  600 , maxWidth: 600,);
                      if (pickedFile != null) {
                          File image  = File(pickedFile.path);
                          uploadFile(image);
                          Navigator.of(context).pop();
                        } else {
                          print('No image selected.');
                        }
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () async {
                    final pickedFile = await picker.getImage(source: ImageSource.camera, maxHeight:  600 , maxWidth: 600,);
                        if (pickedFile != null) {
                          File image  = File(pickedFile.path);
                          uploadFile(image);
                          Navigator.of(context).pop();
                        } else {
                          print('No image selected.');
                        }
                    },
                  ),
                ],
              ),
            ),
          );
        }
      );
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
                              _recipe.name = name
                            }, "Add Name*"),
                            SizedBox(height: 10),
                            InputForm((description) => {
                              _recipe.description = description
                            }, "Add Short Description*"),
                            SizedBox(height: 10),
                            NumberInput((serving) => {
                              _recipe.serving = serving
                            }, "Add Serving*"),
                            SizedBox(height: 10),
                            NumberInput((prepareTime) => {
                              _recipe.prepareTime = prepareTime
                            }, "Add prepare time (min)*"),
                            SizedBox(height: 10),
                            NumberInput((cookingTime) => {
                              _recipe.cookingTime = cookingTime
                            }, "Add cooking time (min)*"),
                            SizedBox(height: 10),
                            InputTextArea((note) => {
                              _recipe.note = note
                            }, "Add note"),
                            SizedBox(height: 10),
                            !loadingPic ?
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.brown[300])),
                              onPressed: () {
                                _showPicker(context);
                              },
                              color: Color(0xffa59671),
                              textColor: Colors.white,
                              child: Container(
                                width: MediaQuery.of(context).size.width - 200,
                                height: 40,
                                alignment: Alignment.center,
                                child: Text(picLoaded?  "Add Recipe" : "Upload Picture", style: TextStyle(fontSize: 14)),
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