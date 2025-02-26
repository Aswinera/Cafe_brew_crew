import 'package:cafe_brew_crew/home/wrapper.dart';
import 'package:cafe_brew_crew/models/user.dart';
import 'package:cafe_brew_crew/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

 void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDZmK4y9Od4TpAbOptS3R6OiDlxBJ4EpCI",
       appId: "1:922657166138:android:a57ab1d37dc0af70253603", 
       messagingSenderId: "922657166138",
        projectId: "cafe-brew-crew-cb669")
  );
   runApp(  MyApp());
}

class MyApp extends StatelessWidget {
 
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return   StreamProvider <Userobj?> .value(
      initialData: null,
      value: AuthSerice().userstream,
      child: MaterialApp(
        home: wrapper(),
      ),
    );
  }
}
