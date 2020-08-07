import 'package:fitness_app/models/Database.dart';
import 'package:fitness_app/models/auth.dart';
import 'package:fitness_app/models/user.dart';
import 'package:fitness_app/pages/FirstPage.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/Screens/Login/login_screen.dart';
import 'package:fitness_app/Screens/Signup/components/background.dart';
import 'package:fitness_app/Screens/Signup/components/or_divider.dart';
import 'package:fitness_app/Screens/Signup/components/social_icon.dart';
import 'package:fitness_app/components/already_have_an_account_acheck.dart';
import 'package:fitness_app/components/rounded_button.dart';
import 'package:fitness_app/components/rounded_input_field.dart';
import 'package:fitness_app/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatelessWidget with ChangeNotifier {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseUser googleUser;

  getUser(user) {
    return user;
  }

  database(displayName, email, photoUrl) {
    var newDBUser = User(
        age: 0,
        height: 0,
        sex: '',
        weight: 0,
        displayName: displayName,
        email: email,
        photoUrl: photoUrl);
    DBProvider.db.newUser(newDBUser);
  }

  setLocalData(gmail, displayName, photoUrl) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("gmail", gmail);
    prefs.setString("displayName", displayName);
    prefs.setString("photoUrl", photoUrl);
    print("inside prefs gmail is: $gmail");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final auth = Provider.of<Auth>(context, listen: false);
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () {},
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {
                    auth.signInWithGoogle()
                        // signInWithGoogle()
                        .then((FirebaseUser user) {
                      // getUser(user);
                      // googleUser = user;
                      setLocalData(user.email, user.displayName, user.photoUrl);
                      database(user.displayName, user.email, user.photoUrl);
                      // print(user.displayName);
                      // print(user.photoUrl);

                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                        return FirstPage();
                      }));
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
