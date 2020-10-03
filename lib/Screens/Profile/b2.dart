import 'package:fitness_app/models/auth.dart';
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
  @override
  _BasicInformationState createState() => _BasicInformationState();
}

class _BasicInformationState extends State<BasicInformation> {
  final databaseRef = Firestore.instance;
  String uid;
  final FirebaseAuth auth = FirebaseAuth.instance;

  var box;
  var userBox;
  @override
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  @override
  void initState() {
    super.initState();
    open();
  }

  open() async {
    //   box = await Hive.openBox('Basic_Information');
    //   userBox = await Hive.openBox('userBox');
    //   final email = (box.get('email'));
    //   final height = (box.get('height'));
    //   final name = (box.get('name'));
    //   final weight = (box.get('weight'));
    // if (name != null) {
    //   nameController.text = name;
    //   emailController.text = email;
    //   heightController.text = height;
    //   weightController.text = weight;
    // }

    SharedPreferences.getInstance().then((value) {
      uid = value.getString('currentUid');
      print('uid is: $uid');
    });
    getAllData();

    getData(uid);
  }

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

  void getData(val) async {
    databaseRef
        .collection('users')
        .document(val)
        .get()
        .then((value) => print(value.data));
  }

  void updateData() {
    try {
      databaseRef.collection('users').document(uid).updateData({
        'displayName': nameController.text,
        'height': heightController.text,
        'weight': weightController.text,
      });
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

  Widget buildBasicInformation(
      String text, IconData icon, Size size, controller) {
    return Row(
      children: <Widget>[
        Icon(icon),
        SizedBox(
          width: size.width * 0.04,
        ),
        TextFieldContainer(
          child: TextField(
            controller: controller,
            onChanged: (_) {
              box.put(text: controller.text);
            },
            cursorColor: kPrimaryColor,
            decoration: InputDecoration(
              hintText: text,
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildChooseGender(Size size) {
    // bool isMale = true;
    return Row(
      children: <Widget>[
        Icon(Icons.access_alarm),
        // SizedBox(width: size.width*0.1,),
        Container(
          width: size.width * 0.375,
          margin: EdgeInsets.only(left: 18),
          child: RoundedButton(
            text: 'Male',
            press: () {
              // isMale = true;
            },
            // color: isMale ? kPrimaryColor : kPrimaryLightColor,
          ),
        ),
        SizedBox(
          width: size.width * 0.05,
        ),
        Container(
            width: size.width * 0.375,
            child: RoundedButton(
              text: 'Female',
              press: () {
                // isMale = false;
              },
              // color: isMale ?kPrimaryLightColor: kPrimaryColor,
            )),

        // RoundedButton(text: 'Female',),
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
          child: Column(
            children: <Widget>[
              buildBasicInformation(
                  'Name', Icons.account_circle, size, nameController),
              buildChooseGender(size),
              buildBasicInformation(
                  'Email', Icons.account_circle, size, emailController),

              buildBasicInformation(
                  'Height', Icons.account_circle, size, heightController),
              buildBasicInformation(
                  'Weight', Icons.account_circle, size, weightController),
              buildBasicInformation('BMI', Icons.account_circle, size, null),
              // buildBasicInformation('Name', Icons.account_circle, size),
            ],
          ),
        ),
        // ),
      ),
      bottomNavigationBar: Container(
        height: size.height * 0.065,
        child: RaisedButton(
          onPressed: () {
            box.put('name', nameController.text);
            box.put('email', emailController.text);
            box.put('height', heightController.text);
            box.put('weight', weightController.text);
            print('printing from user box');
            print(userBox.get('gmail'));

            // user.getCurrenUser().then((id)=>print(id));
            print(uid);
            SharedPreferences.getInstance().then((value) {
              final res = value.getString('currentUid');
              print(res);
            });
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
}

