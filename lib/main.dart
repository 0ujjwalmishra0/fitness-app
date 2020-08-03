import 'package:fitness_app/Screens/Profile/BasicInformation.dart';
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

      home: FirstPage(),
      // BasicInformation(),
      // WelcomeScreen(),
      theme: ThemeData(
        brightness: Brightness.light,
        // primaryColor: Color(0xFF6F35A5),
        primaryColor: Color(0xFF84AB5C),
        accentColor: Colors.cyan[600],
        scaffoldBackgroundColor: Colors.white,
        // We apply this to our appBarTheme because most of our appBar have this style
          appBarTheme: AppBarTheme(color: Colors.white, elevation: 0),
          visualDensity: VisualDensity.adaptivePlatformDensity,

        
        fontFamily: 'OpenSans',

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
