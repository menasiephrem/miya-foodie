import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodie/models/recipe.dart';

class MyDynamicHeader extends SliverPersistentHeaderDelegate {
  int index = 0;
  MyDynamicHeader(this.recipe);
  final Recipe recipe;
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return LayoutBuilder(
        builder: (context, constraints) {
          final double percentage = (maxExtent - minExtent)/(constraints.maxHeight - minExtent);
          return Container(
            width: MediaQuery.of(context).size.width, 
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(this.recipe.img),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.17), BlendMode.srcOver),
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
            child: Stack(
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: percentage - 1, sigmaY: percentage - 1),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 50, left: 15),
                  child: InkWell(
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
                  )
                )
              ],
            ),
          );
        }
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate _) => true;

  @override
  double get maxExtent => 350.0;

  @override
  double get minExtent => 80.0;
}