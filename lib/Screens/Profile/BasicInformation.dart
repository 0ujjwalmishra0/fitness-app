import 'dart:convert';

import 'package:fitness_app/Screens/Profile/editProfile.dart';
import 'package:fitness_app/models/auth.dart';
import 'package:fitness_app/models/custom_route.dart';
import 'package:fitness_app/models/user.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

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

  // Future<User> getData() async {
  //   if (this.user != null) return user;

  //   databaseRef.collection('users').document(uid).get().then((value) {
  //     print(value.data);
  //     user = User.fromMap(value.data);

  //     print('height is : ${user.displayName}');
  //     name = user.displayName;
  //     email = user.email;
  //     height = user.height == null ? '' : user.height.toString();
  //     weight = user.weight == null ? '' : user.weight.toString();
  //     // bmi = (user.weight / (user.height * user.height)).toStringAsFixed(2);
  //     selectedRadio = value.data['gender'];
  //     return user;
  //   });
  // }

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

  Widget buildInfo(String text, String icon, infoType) {
    return ListTile(
      // leading: Icon(icon),
      leading: Image.asset('assets/images/'+icon , height:33),
      title: Text('  $text'),
      subtitle: Text(infoType == '' ? '' : '  $infoType',
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
            onPressed: () {
              print(profile.data['displayName']);
              print(profile.data['height(cm)']);
            },
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
                    buildInfo('Name', 'name.png',
                        profile.data['displayName']),
                    buildInfo(
                        'Email','email.png', profile.data['email']),
                    buildInfo('Height(cm)', 'height2.png',
                        profile.data['height(cm)'].toString()),
                    buildInfo('Weight(Kg)', 'weight.png',
                        profile.data['weight(kg)'].toString()),
                        
                    (profile.data['height(cm)']== null || profile.data['weight(kg)']==null) 
                    ? Text('') 
                    : buildInfo(
                        'BMI',
                        'bmi.png',(double.parse(profile.data['weight(kg)'])*10000 /
                                (double.parse(profile.data['height(cm)']) *
                                    double.parse(profile.data['height(cm)'])))
                            .toStringAsFixed(2)),

                    //TODO: for adding gender
                    // buildGender(size),
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
      bottomNavigationBar: Container(
        height: size.height * 0.065,
        child: RaisedButton(
          onPressed: () {
            updateData();
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
