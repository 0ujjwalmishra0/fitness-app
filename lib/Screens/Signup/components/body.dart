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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return 'signInWithGoogle succeeded: $user';
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();

    print("User Sign Out");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                    final currentUser = signInWithGoogle()
                        .whenComplete(() {
                      // final currentUser = Provider.of<Auth>(context,listen: false).user;
                      // print(currentUser.displayName);
                      // print(currentUser.email);
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                        return FirstPage();
                      }));
                    });
                    // final currentUser = signInWithGoogle().whenComplete(() {
                    //   Navigator.of(context).pushReplacement(
                    //       MaterialPageRoute(builder: (context) {
                    //     return FirstPage();
                    //   }));
                    // });
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
