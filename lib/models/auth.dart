import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/Screens/Welcome/welcome_screen.dart';
import 'package:fitness_app/models/custom_route.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseUser user;
  String name;
  String email;
  String imageUrl;
  String currentUid;

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoUrl != null);

/*** Info we get from user object */
    name = user.displayName;
    email = user.email;
    imageUrl = user.photoUrl;
    currentUid = user.uid;

    final FirebaseUser currentUser = await _auth.currentUser();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('currentUid', currentUid);
    prefs.setString('name', name);
    prefs.setString('imageUrl', imageUrl);

    assert(user.uid == currentUser.uid);

    return user;
  }

  void signOutGoogle(context) async {
    await googleSignIn.signOut().then((value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('email');
      prefs.remove('currentUid');
      prefs.remove('name');
      prefs.remove('imageUrl');
    });
    Navigator.of(context)
        .pushReplacement(CustomRoute(builder: (ctx) => WelcomeScreen()));

    print("User Sign Out");
  }

  getCurrenUser() async {
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    return uid;
  }
}
