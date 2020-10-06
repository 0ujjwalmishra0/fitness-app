import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fitness_app/Screens/Meals/Meals.dart';
import 'package:fitness_app/constants.dart';
import 'package:fitness_app/models/DarkTheme.dart';
import 'package:fitness_app/pages/Detect.dart';
import 'package:fitness_app/pages/Insights.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Screens/Profile/Profile.dart';

class FirstPage extends StatefulWidget {
  String id;
  FirstPage(this.id);
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  PageController pageController = PageController(
    initialPage: 0,
    // keepPage: true,
  );

  int pageIndex = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  selectPage(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 200),
    );
  }

  onPageChanged(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme =
        Provider.of<DarkThemeProvider>(context, listen: false).darkTheme;
    return Scaffold(
      body: PageView(
        children: <Widget>[
          Meals(widget.id),
          Insights(),
          Detect(),
          Profile(widget.id),
        ],
        controller: pageController,
        onPageChanged: (index) => onPageChanged(index),
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: buildCurvedNavigationBar(
          _bottomNavigationKey, pageIndex, selectPage, isDarkTheme),
    );
  }
}

// using curved_navigation_bar package
CurvedNavigationBar buildCurvedNavigationBar(
    _bottomNavigationKey, pageIndex, selectPage, isDarkTheme) {
  return CurvedNavigationBar(
    buttonBackgroundColor: kbottomNavigationColor,
    key: _bottomNavigationKey,
    index: pageIndex,
    height: 50,
    color: kbottomNavigationColor,
    backgroundColor: isDarkTheme ? Colors.black : Colors.white,
    animationCurve: Curves.easeInOut,
    animationDuration: Duration(milliseconds: 250),
    onTap: selectPage,
    items: [
      Icon(
        Icons.home,
        color: Colors.white,
      ),
      Icon(
        Icons.add,
        color: Colors.white,
      ),
      Icon(
        Icons.camera_alt,
        color: Colors.white,
      ),
      Icon(
        Icons.account_circle,
        color: Colors.white,
      ),
    ],
  );
}

/*** previous bottom navigation bar ***/
// buildBottomNavigation(pageIndex,selectPage){
//   return BottomNavigationBar(
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         selectedItemColor: Color(0xffE25E60),
//         unselectedItemColor: Colors.black.withOpacity(0.78),
//         elevation: 3,
//         currentIndex: pageIndex,
//         onTap: selectPage,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             title: Text('Home'),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.account_box),
//             title: Text('Plans'),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.account_circle),
//             title: Text('Profile'),
//           ),],);
// }
