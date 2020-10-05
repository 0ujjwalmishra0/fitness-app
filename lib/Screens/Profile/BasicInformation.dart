import 'dart:convert';

import 'package:fitness_app/Screens/Profile/editProfile.dart';
import 'package:fitness_app/models/auth.dart';
import 'package:fitness_app/models/custom_route.dart';
import 'package:fitness_app/models/user.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/components/rounded_button.dart';
import 'package:fitness_app/components/text_field_container.dart';
import 'package:fitness_app/constants.dart';
import 'package:hive/hive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BasicInformation extends StatefulWidget {
  String profileId;
  BasicInformation(this.profileId);
  @override
  _BasicInformationState createState() => _BasicInformationState();
}

class _BasicInformationState extends State<BasicInformation> {
  final databaseRef = Firestore.instance;
  String uid;
  final FirebaseAuth auth = FirebaseAuth.instance;
  int selectedRadio;
  var box;
  var userBox;
  @override
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController bmiController = TextEditingController();
  String name;
  String email;
  String height;
  String weight;
  String bmi;
  DocumentSnapshot profile;
  User user;

  @override
  void initState() {
    getUserData().then((result) {
      setState(() {
        profile = result;
      });
    });
    super.initState();
  }

  // open() async {
  //   box = await Hive.openBox('Basic_Information');
  //   userBox = await Hive.openBox('userBox');
  //   final email = (box.get('email'));
  //   final height = (box.get('height'));
  //   final name = (box.get('name'));
  //   final weight = (box.get('weight'));

  //   // if (name != null) {
  //   //   nameController.text = name;
  //   //   emailController.text = email;
  //   //   heightController.text = height;
  //   //   weightController.text = weight;
  //   // }
  // }

  void createRecord() async {
    await databaseRef
        .collection('users')
        .document('1')
        .setData({'title': 'Ujjwal', 'desc': 'i am ujjwal'});
  }

  void getAllData() {
    databaseRef
        .collection('users')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((element) {
        print(element.data);
      });
    });
  }

  getUserData() async {
    return await databaseRef
        .collection('users')
        .document(widget.profileId)
        .get();
  }

  Future<User> getData() async {
    if (this.user != null) return user;

    databaseRef.collection('users').document(uid).get().then((value) {
      print(value.data);
      user = User.fromMap(value.data);

      print('height is : ${user.displayName}');
      name = user.displayName;
      email = user.email;
      height = user.height.toString();
      weight = user.weight.toString();
      bmi = (user.weight / (user.height * user.height)).toStringAsFixed(2);
      selectedRadio = value.data['gender'];
      return user;

      // final varheight = value.data['height'];
      // final varweight = value.data['weight'];
      // final varbmi = varweight * 10000 / (varheight * varheight);

      // name = value.data['displayName'];
      // email = value.data['email'];
      // height = varheight.toString();
      // weight = varweight.toString();
      // bmi = varbmi.toStringAsFixed(2);
      // selectedRadio = value.data['gender'];
    });
  }

  void updateData() {
    try {
      databaseRef.collection('users').document(uid).updateData({
        'displayName': nameController.text,
        'weight': double.parse(weightController.text),
        'height': double.parse(heightController.text),
        'gender': selectedRadio,
      });
      print("successfully updated!");
    } catch (e) {
      print(e.toString());
    }
  }

  void deleteData() {
    try {
      databaseRef.collection('users').document('1').delete();
    } catch (e) {
      print(e.toString());
    }
  }

  Widget buildInfo(String text, IconData icon, String infoType) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      subtitle: Text(infoType==null ? '': infoType,
          style: TextStyle(fontSize: 16, color: Colors.green)),
      visualDensity: VisualDensity.compact,
      onTap: () => editProfilePage(text, infoType),
    );
  }

// Changes the selected value on 'onChanged' click on each radio button
  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  buildRadio(String myGoal, int value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(myGoal),
        Radio(
            value: value,
            groupValue: selectedRadio,
            activeColor: kPrimaryColor,
            onChanged: (value) {
              print("Radio $value");
              setSelectedRadio(value);
            }),
      ],
    );
  }

  buildGender(size) {
    return Row(
      children: [
        Icon(Icons.access_alarm),
        SizedBox(width: size.width * 0.08),
        buildRadio('Male', 1),
        buildRadio('Female', 2),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context, listen: false);
    user.getCurrenUser().then((id) => uid = id);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Basic Information'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {},
            child: Text('Done'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: (profile != null)
                ? Column(
                    children: <Widget>[
                      buildInfo('Name', Icons.account_circle,
                          profile.data['displayName']),
                      buildInfo(
                          'Email', Icons.account_circle, profile.data['email']),
                      buildInfo('Height(cm)', Icons.account_circle,
                          profile.data['height'].toString()),
                      buildInfo('Weight(Kg)', Icons.account_circle,
                          profile.data['weight'].toString()),
                      buildInfo(
                          'BMI',
                          Icons.account_circle,(profile.data['weight']*10000 /
                                  (profile.data['height'] *
                                      profile.data['height']))
                              .toStringAsFixed(2)),

                      //TODO: for adding gender        
                      // buildGender(size),
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  )

            // FutureBuilder(
            //   future: getData(),
            //   builder: (context, snapshot) {
            //     print(snapshot.connectionState.toString());
            //     print(snapshot.hasData);
            //     if (snapshot.connectionState == ConnectionState.waiting ||
            //         snapshot.hasData == null) {
            //       return Center(child: CircularProgressIndicator());
            //     } else {
            //       if (snapshot.error != null) {
            //         return Text('an error occurred ${snapshot.error}');
            //       } else {
            //         return Column(
            //           children: <Widget>[
            //             buildInfo('Name', Icons.account_circle, name),
            //             buildInfo('Email', Icons.account_circle, email),
            //             buildInfo('Height', Icons.account_circle, height),
            //             buildInfo('Weight', Icons.account_circle, weight),
            //             buildInfo('BMI', Icons.account_circle, bmi),
            //             buildGender(size),
            //           ],
            //         );
            //       }
            //     }
            //   },
            // ),
            ),
      ),
      bottomNavigationBar: Container(
        height: size.height * 0.065,
        child: RaisedButton(
          onPressed: () {
            updateData();

            // box.put('name', nameController.text);
            // box.put('email', emailController.text);
            // box.put('height', heightController.text);
            // box.put('weight', weightController.text);

            // print(userBox.get('gmail'));

            // user.getCurrenUser().then((id)=>print(id));
            // print(uid);

            // SharedPreferences.getInstance().then((value) {
            //   final res = value.getString('currentUid');
            //   final res2 = value.getString('email');
            //   print('currentUid: $res');
            //   print('email: $res2');
            // });
          },
          child: Text(
            'Done',
            style: TextStyle(color: Colors.white),
          ),
          color: kPrimaryColor,
        ),
      ),
    );
  }

  editProfilePage(String text, String infoType) {
    if (text != 'BMI')
      Navigator.of(context).push(
        CustomRoute(
          builder: (context) => EditProfile(
            text: text,
            infoType: infoType,
            userId: uid,
          ),
        ),
      );
  }
}
