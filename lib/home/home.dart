import 'package:cafe_brew_crew/home/brew_list.dart';
import 'package:cafe_brew_crew/services/auth.dart';
import 'package:cafe_brew_crew/models/brew.dart';
import 'package:flutter/material.dart';
import 'package:cafe_brew_crew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cafe_brew_crew/home/settings_forms.dart';

class Home extends StatelessWidget {

final AuthSerice _auth= AuthSerice();


  @override
  Widget build(BuildContext context) {

void _showSettingsPanel(){
  showModalBottomSheet(context: context, builder: (context){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
      child: SettingsForm(),
    );
  }
  ); 
}

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService(uid: "").brews,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("Brew Crew"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
                
               icon: Icon(Icons.person),
               label: Text("logout"),
               onPressed: () async{
                        await _auth.signOut();
               },),
               TextButton.icon(
                
               icon: Icon(Icons.settings),
               label: Text("settings"),
               onPressed: ()=>_showSettingsPanel(), 
               ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: BrewList()),
        ),
    );
  }
}