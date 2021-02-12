import 'package:flutter/material.dart';

class DirectionsListItem extends StatelessWidget {
  const DirectionsListItem(this.title, this.detail, this.step);
  final String title;
  final String detail;
  final int step;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
                CircleAvatar(
                  radius: 13,
                  backgroundColor: Color(0xffa59671),
                  child: Center(
                    child: Text(
                      "${this.step + 1}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  this.title,
                  style: TextStyle(color:  Color(0xffa59671), fontSize: 15, fontWeight: FontWeight.w600),
                )
            ],
          ),
          SizedBox(height: 10),
          Text(
            this.detail,
            style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10),
          Divider(height: 5, color: Colors.black54,), 
        ],
      ),
    );
  }
}