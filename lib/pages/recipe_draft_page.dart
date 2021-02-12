import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodie/components/app_bar/dynamic_header.dart';
import 'package:foodie/components/recipes/directions_list.dart';
import 'package:foodie/components/recipes/ingredients_list.dart';
import 'package:foodie/components/recipes/ingredinets_draft_list.dart';
import 'package:foodie/components/starts.dart';
import 'package:foodie/models/recipe.dart';
import 'package:foodie/services/recipe_services.dart';
import 'package:foodie/utils/general_util.dart';
import 'package:image_picker/image_picker.dart';

import '../finder.dart';
import 'edit_recipe.dart';

class RecipeDraftPage extends StatefulWidget {
  RecipeDraftPage(this.recipe);
  final Recipe recipe;
  @override
  _RecipeDraftPageState createState() => _RecipeDraftPageState();
}

class _RecipeDraftPageState extends State<RecipeDraftPage> {
  

    Recipe _recipe;
    final picker = ImagePicker(); 
    RecipeService _recipeService = locator<RecipeService>();
    bool picLoaded = false;
    bool loading = false;
    BuildContext _context;

    @override
  void initState() {
    setState(() {
      _recipe = this.widget.recipe;
    });
    super.initState();
  }


    void _handleClick(String value) {
      switch (value) {
        case 'Edit':
            Navigator.push(
              _context,
              MaterialPageRoute(builder: (context) => EditRecipe(this._recipe))
            ).then((value) => {
              setState((){
                _recipe = value;
              })
            });
          break;
        case 'Change Picture':
          _showPicker(_context);
          break;
        case 'Publish Changes':
          break;  
      }
    } 

    List<Widget> _appBarActions(){
      return [
          PopupMenuButton<String>(
            onSelected: _handleClick,
            itemBuilder: (BuildContext context) {
              return {'Edit', 'Change Picture', 'Publish Changes'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ];
    }

    Future uploadFile(File _image) async {   
        setState(() {
          loading = true;
        });  
        Reference storageReference = FirebaseStorage.instance    
            .ref()    
            .child('foodPics/${DateTime.now().microsecondsSinceEpoch}');    
        UploadTask uploadTask = storageReference.putFile(_image);    
        await uploadTask;    
        print('File Uploaded');    
        storageReference.getDownloadURL().then((fileURL) { 
          _recipe.img = fileURL;
          _updateRecipe(_recipe);
        });    
   } 

    void _updateRecipe(Recipe rec) async {
      await _recipeService.updateRecipeDraft(rec);
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
    setState(() {
      _context = context;
    });
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light, 
          child: Stack(
            children: [
                  CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    floating: false,
                    delegate: MyDynamicHeader(this.widget.recipe, _appBarActions()),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              SizedBox(height: 25),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        this.widget.recipe.name,
                                        style: TextStyle(color: Color(0xffa59671), fontWeight: FontWeight.w700, fontSize: 26)
                                      ),
                                      Text(
                                        prepareDesc(this.widget.recipe.description, 43),
                                        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 16)
                                      )
                                    ],
                                  ), 
                                  Spacer(),
                                  Column(
                                    children: [
                                      Text(
                                        "${this.widget.recipe.voteCount}",
                                        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16)
                                      ),
                                      Text(
                                        "Views",
                                        style: TextStyle(color: Colors.grey, fontSize: 12)
                                      ),
                                    ],
                                  )
                                ]
                              ), 
                              SizedBox(height: 15),
                              Row(
                                children: [
                                RatingStarts(this.widget.recipe.voteCount > 0? this.widget.recipe.rating/this.widget.recipe.voteCount: 0),
                                SizedBox(width: 5),
                                Text(
                                    "(${this.widget.recipe.voteCount} Reviews)",
                                    style: TextStyle(color: Colors.brown, fontSize: 12)
                                  ),
                                  Spacer(),
                                Text("This a draft!!")
                                ],
                              ),
                              SizedBox(height: 10),
                              Divider(height: 10, color: Colors.black54,), 
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Servings",
                                        style: TextStyle(color: Colors.grey, fontSize: 12)
                                      ),
                                      Text(
                                        "${this.widget.recipe.serving}pp",
                                        style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Prep. Time",
                                        style: TextStyle(color: Colors.grey, fontSize: 12)
                                      ),
                                      Text(
                                        "${this.widget.recipe.prepareTime}m",
                                        style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Cook Time",
                                        style: TextStyle(color: Colors.grey, fontSize: 12)
                                      ),
                                      Text(
                                        "${this.widget.recipe.cookingTime}m",
                                        style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Description",
                                    style: TextStyle(color: Colors.grey, fontSize: 12)
                                  ),
                                  Text(
                                    this.widget.recipe.note != null ? this.widget.recipe.note: "",
                                    style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold)
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                            ]
                          )
                        ),
                        Container(
                          color: Colors.grey[100],
                          child: TabBar(
                            labelColor: Color(0xffa59671),
                            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                            tabs: [
                              Tab(text: "Ingredient"),
                              Tab(text: "Directions"),
                            ],
                          )
                        ),
                        Container(
                          height: 500,
                          child: TabBarView(
                            children: [
                              IngredientsDraft( _recipe, _updateRecipe),
                              Directions(this.widget.recipe.directions == null ? []: this.widget.recipe.directions),
                            ],
                          ),
                        )
                      ]
                    ),
                  )
                ],
              ),
              Center(
                child:  loading ? CircularProgressIndicator() : Text(""),
              )
            ],
          )
        )
      )
    );
  }
}