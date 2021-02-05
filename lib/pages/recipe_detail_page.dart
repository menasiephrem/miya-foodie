import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodie/components/app_bar/dynamic_header.dart';
import 'package:foodie/models/recipe.dart';

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
      length: 3,
      child: Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light, 
          child: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                floating: false,
                delegate: MyDynamicHeader(this.widget.recipe),
              )
            ],
          )
        )
      )
    );
  }
}