import 'package:flutter/material.dart';

class IngridientListItem extends StatelessWidget {
  const IngridientListItem(this.item);
  final String item;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      height: 50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            item,
            style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10),
          Divider(height: 5, color: Colors.black54,), 
        ],
      ),
    );
  }
}