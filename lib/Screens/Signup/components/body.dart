import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/models/auth.dart';
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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';


class Body extends StatelessWidget with ChangeNotifier {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseUser googleUser;
  final usersRef = Firestore.instance.collection('users');
  final mydoc = Firestore.instance.collection('mydoc');
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  getUser(user) {
    return user;
  }

  var userBox;
  setLocalData(gmail, displayName, photoUrl) async {
    // final prefs = await SharedPreferences.getInstance();
    // prefs.setString("gmail", gmail);
    // prefs.setString("displayName", displayName);
    // prefs.setString("photoUrl", photoUrl);
    // print("inside prefs gmail is: $gmail");
    userBox = await Hive.openBox('userBox');
    userBox.put('email', gmail);
    userBox.put('displayName', displayName);
    userBox.put('photoUrl', photoUrl);
  }

  setFirebaseData(user) async {
    // final id = usersRef.document().documentID;
    usersRef.document(user.uid).setData({
      'id': user.uid,
      'displayName': user.displayName,
      'photoUrl': user.photoUrl,
      'email': user.email,
    });
   
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
            // RoundedInputField(
            //   hintText: "Your Email",
            //   onChanged: (value) {},
            // ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ),
                hintText: 'Enter your email',
              ),
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ),
                hintText: 'Enter your password',
              ),
            ),
            // RoundedPasswordField(
            //   onChanged: (value) {},
            // ),
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
                      setFirebaseData(user);
                      setLocalData(user.email, user.displayName, user.photoUrl);

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

  signUpUsingEmail(String email, String password, BuildContext context) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((signedInUser) async {
      setFirebaseData(signedInUser.user);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    userBox.close();
    super.dispose();
  }
}
