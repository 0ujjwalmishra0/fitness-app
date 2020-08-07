import 'package:fitness_app/Screens/Profile/BasicInformation.dart';
import 'package:fitness_app/Screens/Profile/components/info.dart';
import 'package:fitness_app/Screens/Profile/components/profile_menu_item.dart';
import 'package:fitness_app/Screens/Profile/goal.dart';
import 'package:fitness_app/components/listTile.dart';
import 'package:fitness_app/constants.dart';
import 'package:fitness_app/models/DarkTheme.dart';
import 'package:fitness_app/models/Database.dart';
import 'package:fitness_app/models/auth.dart';
import 'package:fitness_app/models/custom_route.dart';
import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String gmail;
  String displayName;
  String photoUrl;

  Map<String, String> newUser = {};
  Future _userFuture;

  Future getLocalData() async {
    final prefs = await SharedPreferences.getInstance();
    gmail = await prefs.getString('gmail');
    displayName = await prefs.getString('displayName');
    photoUrl = await prefs.getString('photoUrl');
    // print("inside getLocal data");
    // print("name is $displayName");
    // print('photo is $photoUrl');
    // print('gmail is $gmail');
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    // getLocalData();
    _userFuture = getUser();
  }

  getUser() async {
    final _userData = await DBProvider.db.getUser();
    return _userData;
  }

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<signupBody.Body>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    final themeChange = Provider.of<DarkThemeProvider>(context);
    Widget _buildSwitchTile(String title, String iconSrc) {
      Size size = MediaQuery.of(context).size;
      double defaultSize = SizeConfig.defaultSize;
      return Padding(
        padding: EdgeInsets.only(
          left: defaultSize * 3,
          top: defaultSize*1.4,
        ),
        child: Row(
          children: <Widget>[
            SvgPicture.asset(iconSrc),
            SizedBox(width: defaultSize * 2),
            Text(
              title,
              style: TextStyle(
                fontSize: defaultSize * 1.6, //16
                color: kTextLigntColor,
              ),
            ),
            Spacer(),
            
            Switch(
                value: themeChange.darkTheme,
                onChanged: (bool value) {
                  if (value)
                    themeChange.darkTheme = true;
                  else
                    themeChange.darkTheme = false;
                }),
                SizedBox(
              width: size.width*0.03,
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: FutureBuilder(
        future: getLocalData(),
        // _userFuture,
        builder: (context, userData) {
          switch (userData.connectionState) {
            case ConnectionState.none:
              return Container();
            case ConnectionState.waiting:
              return Container();
            case ConnectionState.active:
            case ConnectionState.done:
              // if (!newUser.containsKey('displayName')) {
              //     newUser = Map<String, String>.from(userData.data);
              //   }
              return Column(
                children: <Widget>[
                  Info(
                    image: photoUrl,
                    // "https://scontent-vie1-1.cdninstagram.com/v/t51.2885-19/101292696_278815523249225_1135093752491147264_n.jpg?_nc_ht=scontent-vie1-1.cdninstagram.com&_nc_ohc=sCh_E0GkJ8cAX_HkBB0&oh=005798e859b99e2c95e60ea9aa8efc8f&oe=5F51237F",
                    name: displayName,
                    email: gmail,
                  ),
                  SizedBox(height: SizeConfig.defaultSize * 2), //20
                  ProfileMenuItem(
                    iconSrc: "assets/icons2/bookmark_fill.svg",
                    title: "Saved Foods",
                    press: () {},
                  ),
                  ProfileMenuItem(
                    iconSrc: "assets/icons2/chef_color.svg",
                    title: "Super Plan",
                    press: () {},
                  ),
                  ProfileMenuItem(
                    iconSrc: "assets/icons2/language.svg",
                    title: "Basic Information",
                    press: () {
                      Navigator.of(context).push(
                          CustomRoute(builder: (ctx) => BasicInformation()));
                    },
                  ),
                  ProfileMenuItem(
                    iconSrc: "assets/icons2/info.svg",
                    title: "My Goal",
                    press: () {
                      Navigator.of(context)
                          .push(CustomRoute(builder: (ctx) => Goal()));
                    },
                  ),
                  ProfileMenuItem(
                    iconSrc: "assets/icons2/info.svg",
                    title: "Logout",
                    press: () {
                      auth.signOutGoogle(context);
                    },
                  ),
                  _buildSwitchTile(
                    "Dark Mode",
                    "assets/icons2/info.svg",
                  ),
                ],
              );
          }

          // switch (userData.connectionState) {
          //   case ConnectionState.none:
          //     return Container();
          //   case ConnectionState.waiting:
          //     return Container();
          //   case ConnectionState.active:
          //   case ConnectionState.done:

          //     if (!newUser.containsKey('displayName')) {
          //       newUser = Map<String, String>.from(userData.data);
          //     }

          //     return Column(
          //       children: <Widget>[
          //         Text(newUser['displayName']),
          //       ],
          //     );
          // }
        },
        // child:
      ),
    );
  }
}
