import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodie/models/catagory.dart';
import 'package:foodie/pages/add_recipe.dart';
import 'package:foodie/utils/general_util.dart';

class CatagoryPage extends StatefulWidget {
  CatagoryPage(this.catagory);

  final Catagory catagory;
  @override
  _CatagoryPageState createState() => _CatagoryPageState();
}

class _CatagoryPageState extends State<CatagoryPage> {

  bool _userLoggedIn = false;
  String _loggedInUser;

  @override
  void initState() {
    super.initState();
    _checkIfUser();
  }

  void _checkIfUser() async{
   bool _user = await isUserLoggedIn();
   if(_user){
     String userName = await getLoggedInUser();
    setState(() {
      _userLoggedIn = _user;
      _loggedInUser = userName;
    });
   }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light, 
          child: Container(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width, 
                  height: 350,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/${this.widget.catagory.img}.jpeg"),
                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.17), BlendMode.srcOver),
                      fit: BoxFit.cover,
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
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 50,),
                        InkWell(
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
                        ),
                        SizedBox(height: 175,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              this.widget.catagory.name,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 50,
                              ),
                            ),
                            SizedBox(height: 1,),
                            Text(
                              this.widget.catagory.description,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                TabBar(
                  labelColor: Color(0xffa59671),
                  labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  tabs: [
                    Tab(text: "All"),
                    Tab(text: "Popular"),
                    Tab(text: "New"),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Center(child:Text("All")),
                      Center(child:Text("Popular")),
                      Center(child:Text("New")),
                    ],
                  ),
                )
                
              ],
            ),
          ),
        ),
        floatingActionButton: !_userLoggedIn? null : 
          FloatingActionButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddRecipe(_loggedInUser, this.widget.catagory.name))
              );
            },
            backgroundColor: Color(0xffa59671),
            child: Icon(Icons.add)
          ),
      )
    );
  }
}