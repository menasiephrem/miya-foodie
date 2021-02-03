import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodie/components/food_cat_card_item.dart';

class MainPage extends StatefulWidget {
  MainPage();

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

 int tabIndex = 0;
 List<String> catagoryImg = ["bf", "lunch", "snack", "dinner"];
 List<String> catagoryName = ["Breakfast", "Lunch", "Snacks", "Dinner"];
 List<String> catagoryDesc = ["Healty Breakfast Ideas", "Quick Lunch Ideas", "Fast Snacks", "Erat 😊"];


  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Container(
            padding: EdgeInsets.only(top: 80),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Popular Recipes",
                  style: TextStyle(color: Color(0xffa59671), fontWeight: FontWeight.w700, fontSize: 24),
                ),
                SizedBox(height: 20,),
               Expanded(
                 child: Container(
                   width: MediaQuery.of(context).size.width - 20,
                   child:ListView.builder(
                      itemCount: 4,
                      itemBuilder: (con, index) {
                        return FoodCatItem(catagoryImg[index], catagoryName[index], catagoryDesc[index]);
                      },
                    )
                 ) 
               )
              ],
            ),
          ),
        )
      ),
     bottomNavigationBar: BottomNavigationBar(
       unselectedItemColor: Colors.brown[100],
       selectedItemColor: Color(0xffa59671),
       currentIndex: tabIndex, 
       onTap: (index) {
         setState(() {
           tabIndex = index;
         });
       },
       items: [
         BottomNavigationBarItem(
           label: "",
           icon: Icon(Icons.home),
         ),
         BottomNavigationBarItem(
           label: "",
           icon: Icon(Icons.search),
         ),
         BottomNavigationBarItem(
           label: "",
           icon: Icon(Icons.favorite_sharp),
         ),
       ],
     ) 
    );
  }
}