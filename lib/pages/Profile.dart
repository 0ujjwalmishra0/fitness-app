import 'package:fitness_app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: AppDrawer("ujjwal"),
      appBar: AppBar(
        title: Text(
          '',
          // user.displayName,
          style: TextStyle(
              fontFamily: 'OpenSans',
              color: Color(0xff454647),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),),
      
    );
  }
}