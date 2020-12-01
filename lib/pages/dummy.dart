import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Dummy extends StatelessWidget {


  launchURL(String url) async {
    // const url = 'https://www.google.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(child: Container(height: 150, width:150,child:Image.asset("assets/images/apple.jpg",)),onTap: (){
                launchURL('https://www.google.com');
                },),
                //spacing between two pics of same row
                SizedBox(width:30),
                GestureDetector(child: Container(height: 150, width:150,child:Image.asset("assets/images/apple.jpg",)),onTap: (){
                launchURL('https://www.google.com');
                },),
                
            ],
          ),
          //spacing between two rows
          SizedBox(height:30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(child: Container(height: 150, width:150,child:Image.asset("assets/images/apple.jpg",)),onTap: (){
                launchURL('https://www.google.com');
                },),
                //spacing between two pics of same row
                SizedBox(width:30),
                GestureDetector(child: Container(height: 150, width:150,child:Image.asset("assets/images/apple.jpg",)),onTap: (){
                launchURL('https://www.instagram.com');
                },),
                
            ],
          ),
          
        ],
      ),
    );
  }
}
