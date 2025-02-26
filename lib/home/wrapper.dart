import 'package:cafe_brew_crew/home/home.dart';
import 'package:cafe_brew_crew/models/user.dart';
import 'package:cafe_brew_crew/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class wrapper extends StatelessWidget {
 

 
  @override
  Widget build(BuildContext context) {

    final users =Provider.of<Userobj?>(context);
    print(users);

    //return either home or authenticate
   if(users==null){
     return  Authenticate();
   }
   else{
    return Home();
   }
  }
}