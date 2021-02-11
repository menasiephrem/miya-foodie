import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodie/components/app_bar/dynamic_header.dart';
import 'package:foodie/components/recipes/directions_list.dart';
import 'package:foodie/components/recipes/ingredients_list.dart';
import 'package:foodie/components/starts.dart';
import 'package:foodie/models/recipe.dart';
import 'package:foodie/utils/general_util.dart';

class RecipeDetailPage extends StatefulWidget {
  RecipeDetailPage(this.recipe);
  final Recipe recipe;
  @override
  _RecipeDetailPageState createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light, 
          child: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                floating: false,
                delegate: MyDynamicHeader(this.widget.recipe),
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
                                style: TextStyle(color: Colors.grey, fontSize: 12)
                              ),
                              Spacer(),
                              Container(
                                height: 25,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side: BorderSide(color: Colors.grey[300])),
                                  onPressed: () {},
                                  color: Colors.grey[300],
                                  textColor: Colors.white,
                                  child: Container(
                                    width: 60,
                                    height: 15,
                                    alignment: Alignment.center,
                                    child: Text("Add To Fav", style: TextStyle( color: Colors.black, fontSize: 10)),
                                  ),
                                )
                              )
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
                          Tab(text: "Ingredinets"),
                          Tab(text: "Directions"),
                        ],
                      )
                    ),
                    Container(
                      height: 500,
                      child: TabBarView(
                        children: [
                          Ingredients(this.widget.recipe.ingredients == null ? [] : this.widget.recipe.ingredients),
                          Directions(this.widget.recipe.directions == null ? new Map(): this.widget.recipe.directions),
                        ],
                      ),
                    )
                  ]
                ),
              )
            ],
          )
        )
      )
    );
  }
}