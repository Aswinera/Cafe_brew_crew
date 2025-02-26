
import 'package:cafe_brew_crew/models/user.dart';
import 'package:cafe_brew_crew/services/database.dart';
import 'package:cafe_brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:cafe_brew_crew/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  
@override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

final _formKey=GlobalKey<FormState>();
final List<String> sugars=['0','1','2','3','4'];

//form value
  String _currentName="";
   String _currentSugars="";
  int? _currentStrength;

 @override
  Widget build(BuildContext context) {
 final users =Provider.of<Userobj?>(context);

    return StreamBuilder<UserData>( 
      stream: DatabaseService(uid: users!.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
              UserData? userData=snapshot.data;
       return Form(
          key: _formKey,
          child: Column(
            children:<Widget> [
              Text(
                'Update your brew settings',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 20.0,),


              TextFormField(
                decoration: textInputDecoration,
                initialValue: userData!.name,
                validator: (value)=> value!.isEmpty ?'Please enter a name': null,
                onChanged:(value)=> setState(()=> _currentName=value), 
              ),
               SizedBox(height: 20.0,),


               //dropdown
               DropdownButtonFormField(
                decoration: textInputDecoration,
                value:  userData.sugars,
                items:sugars.map((sugar){
                  return DropdownMenuItem(
                    value: sugar,
                    child:Text("$sugar sugars"),
                  );
                }).toList(),
                 onChanged: (value)=>setState(()=> _currentSugars=value!),
                   ),
                   SizedBox(height: 20.0,),

                   
               //slider
               Slider(
                value: ((_currentStrength==null)?  userData.strength : _currentStrength!).toDouble(),
                activeColor: Colors.brown[(_currentStrength==null)?  userData.strength : _currentStrength!],
                inactiveColor: Colors.brown[(_currentStrength==null)?  userData.strength : _currentStrength! ] ,
                min:100.0,
                max:900.0,
                divisions: 8,
                onChanged: (value)=>setState(()=>_currentStrength=value.round()),
                   ),


               ElevatedButton( 
                child: Text('Update',
                style: TextStyle(color: Colors.black),),
                onPressed: ()async{
                  
                  
                  if(_formKey.currentState!.validate()){
                    await DatabaseService(uid: users.uid).updateUserData(
                     _currentSugars.isEmpty? userData.sugars : _currentSugars , 
                     _currentName.isEmpty? userData.name : _currentName, 
                     _currentStrength ?? userData.strength);
                      if (mounted)
                      Navigator.pop(context);
                      print(userData.name);
                      print(userData.sugars);
                      print(userData.strength);
                      print("//");
                      print(_currentName);
                      print(_currentSugars);
                      print(_currentStrength);
                  }
                },
                ),
            ],
          ),
        );
        }else{
             return Loading();
        }
       
      }
    );
  }
}