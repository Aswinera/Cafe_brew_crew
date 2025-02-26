import "package:cafe_brew_crew/services/auth.dart";
import "package:cafe_brew_crew/shared/loading.dart";
import "package:flutter/material.dart";
import 'package:cafe_brew_crew/shared/constants.dart';

class SignIn extends StatefulWidget {

final Function toggleView;
SignIn({required this.toggleView});
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthSerice _auth=AuthSerice();
  final _formKey= GlobalKey<FormState>();
  bool loading=false;

  //text field state
  String email='';
  String password='';
  String error='';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading():Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text("Sign in to Brew Crew"),
        actions:<Widget> [
          TextButton.icon(
            icon: Icon(Icons.person),
            onPressed:(){
               widget.toggleView();
            }, 
            label: Text("Register"),
            )
        ],
      ),
      body: Container(
        padding:  EdgeInsets.symmetric(vertical:20.0,horizontal: 50.0 ),
        child: Form(
           key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 30.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (value)=>value!.isEmpty?'Enter an email':null,
                onChanged:(value) {
                   setState(()=> email=value);
                },
              ),
              SizedBox(height: 30.0,),
              TextFormField(
                decoration:textInputDecoration.copyWith(hintText: 'Password'),
                validator: (value)=>value!.length<6?'Enter a password 6+ chars long':null,
                obscureText: true,
                onChanged: (value) {
                   setState(()=> password=value);
                },
              ),
              SizedBox(height: 30.0,),
              ElevatedButton(
                
                 child: Text('Sign in',
                 style: TextStyle(color: Colors.black,
                 fontSize: 16.0,
                 fontWeight: FontWeight.bold),
                  ),
                 onPressed: ()async {
                    if(_formKey.currentState!.validate()){
                      setState(() =>
                        loading=true
                      );
                     dynamic result=await _auth.signInWithEmailAndPassword(email, password);
                   if(result==null){
                    setState(() { 
                      error = 'could not sign in with those credentials';
                      loading=false;
                   });
                   }
                   }
                 },
                 ),
                 SizedBox(height: 13.0,),
                 Text(error,
                 style: TextStyle(color:Colors.red,fontSize:14.0 ),)
            ],
          ),
        )
      ),
    );
  }
}