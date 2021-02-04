import 'package:flutter/material.dart';
import 'package:foodie/models/catagory.dart';
import 'package:foodie/pages/catagory_page.dart';

class FoodCatItem extends StatelessWidget {
  const FoodCatItem(this.catagory);
  final Catagory catagory;
  @override
  Widget build(BuildContext context) {
    return 
    InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CatagoryPage(this.catagory      ))
        );
      },
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            image: DecorationImage(
              image: AssetImage("assets/images/${this.catagory.img}.jpeg"),
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.17), BlendMode.srcOver),
              fit: BoxFit.cover,
            ),
          ),
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                this.catagory.name,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 40,
                ),
              ),
              Text(
                this.catagory.description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              )
            ],
          ),
        )
  );
  }
}