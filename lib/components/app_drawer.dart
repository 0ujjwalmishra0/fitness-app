import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatelessWidget {
  String username;
  AppDrawer(this.username);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text(
              'Welcome, $username',
              style: TextStyle(fontFamily: 'OpenSans', color: Colors.black),
            ),
            //to remove the back button
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xfff8faf8),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.camera),
            title: Text('Snap'),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(
              'Logout',
              // style: TextStyle(fontSize: 17),
            ),
            onTap: () {
              //it is necessary to first close the drawer and then call logout function
              Navigator.of(context).pop();
              //whenever logout is pressed we will move to home route and hence all data is
              //cleared we will ultimately end up on AuthScreen
              // showing auth screen just after logout

              Navigator.of(context).pushReplacementNamed('/');
              // Provider.of<Auth>(context,listen: false).logout();

              // //clearing the local saved data after logout
              // FirebaseAuth.instance.signOut().then((value) async {
              //   SharedPreferences prefs = await SharedPreferences.getInstance();
              //   prefs.remove('email');
                
              //   Navigator.of(context)
              //       // .pushReplacementNamed(LoginScreen.routeName);
              // }).catchError((e) {
              //   print(e);
              // });
            },
          ),
        ],
      ),
    );
  }
}
