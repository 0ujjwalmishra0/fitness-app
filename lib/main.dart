import 'package:fitness_app/Screens/Signup/components/body.dart' as signupBody;
import 'package:fitness_app/Screens/Welcome/welcome_screen.dart';
import 'package:fitness_app/models/DarkTheme.dart';
import 'package:fitness_app/models/auth.dart';
import 'package:fitness_app/Screens/Meals/AddMeals.dart';
import 'package:fitness_app/pages/FirstPage.dart';
import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

var email;
String uid;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  email = prefs.getString('email');
  uid = prefs.getString('currentUid');
  print("login:" + email.toString());
  // Open the database and store the reference.
  // final Future<Database> database = openDatabase(
  // // Set the path to the database. Note: Using the `join` function from the
  // // `path` package is best practice to ensure the path is correctly
  // // constructed for each platform.
  // join(await getDatabasesPath(), 'doggie_database.db'),
// );
  runApp(MyApp());
}

// void main() {
//   runApp(MyApp());
// }

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider.value(value: signupBody.Body()),
        ChangeNotifierProvider.value(value: themeChangeProvider),
      ],
      // create: (context) => Auth(),
      child: Consumer<DarkThemeProvider>(
        builder: (ctx, auth, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Fitness App',
          home: email == null ? WelcomeScreen() : FirstPage(uid),
          theme: Styles.themeData(themeChangeProvider.darkTheme, context),
          // theme: ThemeData(
          //   brightness: Brightness.light,
          //   // primaryColor: Color(0xFF6F35A5),
          //   primaryColor: Color(0xFF84AB5C),
          //   accentColor: Colors.cyan[600],
          //   scaffoldBackgroundColor: Colors.white,
          //   // We apply this to our appBarTheme because most of our appBar have this style
          //   appBarTheme: AppBarTheme(color: Colors.white, elevation: 0),
          //   visualDensity: VisualDensity.adaptivePlatformDensity,

          //   fontFamily: 'OpenSans',

          //   textTheme: Theme.of(context).textTheme.apply(
          //         fontFamily: 'Open Sans',
          //         bodyColor: Colors.black,
          //         displayColor: Colors.black,

          //         // headline1: TextStyle(fontSize: 42.0, fontWeight: FontWeight.bold),
          //         // headline2: TextStyle(fontSize: 20.0,),
          //         // bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          //       ),
          // ),
          // darkTheme: ThemeData(
          //   brightness: Brightness.dark,
          // ),
          routes: {
            AddMeals.routeName: (ctx) => AddMeals(),
          },
        ),
      ),
    );
  }
}
