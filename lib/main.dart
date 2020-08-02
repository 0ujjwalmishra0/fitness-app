import 'package:fitness_app/Screens/Welcome/welcome_screen.dart';
import 'package:fitness_app/pages/AddMeals.dart';
import 'package:fitness_app/pages/FirstPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitnes App',
      
      home: 
      // FirstPage(),
      WelcomeScreen(),
      theme: ThemeData(
    // Define the default brightness and colors.
    brightness: Brightness.light,
    primaryColor: Colors.amber,
    accentColor: Colors.cyan[600],

    // Define the default font family.
    fontFamily: 'OpenSans',

    // Define the default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: Theme.of(context).textTheme.apply(
      fontFamily: 'Open Sans',
      bodyColor: Colors.black,
      displayColor: Colors.black,

      // headline1: TextStyle(fontSize: 42.0, fontWeight: FontWeight.bold),
      // headline2: TextStyle(fontSize: 20.0,),
      // bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
    
  ),
  routes: {
            AddMeals.routeName: (ctx) => AddMeals(),
            
          },
      
    );
  }
}
