import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatelessWidget {
  // final username;
  // AppDrawer(this.username);
  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            AppBar(
              title: Text(
                'Welcome',
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
            // Divider(),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Add'),
              onTap: (){},
            ),
            // Divider(),
            ListTile(
              leading: Icon(Icons.camera),
              title: Text('Profile'),
              onTap: (){},
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text(
                'Logout',
                // style: TextStyle(fontSize: 17),
              ),
              onTap: (){},
              // onTap: () {
              //   //it is necessary to first close the drawer and then call logout function
              //   Navigator.of(context).pop();
              //   //whenever logout is pressed we will move to home route and hence all data is
              //   //cleared we will ultimately end up on AuthScreen
              //   // showing auth screen just after logout

              //   Navigator.of(context).pushReplacementNamed('/');
               
              // },
            ),
          ],
        ),
      ),
    );
  }
}
