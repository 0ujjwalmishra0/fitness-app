import 'package:fitness_app/pages/Meals.dart';
import 'package:fitness_app/pages/Insights.dart';
import 'package:flutter/material.dart';

import 'Profile.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
    PageController pageController;

  int pageIndex = 0;

    @override
  void initState() {
    // getCurrentUser();
    
    pageController = PageController();
   
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  selectPage(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 200),
    );
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          Meals(),
          Insights(),
          Profile(),

          // profile.Profile(profileId: routeArgs.id,profileUsername: routeArgs.username,)
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Color(0xffE25E60),
        unselectedItemColor: Colors.black.withOpacity(0.78),
        elevation: 3,
        currentIndex: pageIndex,
        onTap: selectPage,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
               title: Text('Home'),
               ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
               title: Text('Plans'),
          ),
          
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
               title: Text('Profile'),
          ),
         
        ],
      ),
    );
  }
}