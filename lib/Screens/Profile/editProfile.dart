import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/constants.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  String text;
  String infoType;
  String userId;
  final databaseRef = Firestore.instance;

  EditProfile({this.text, this.infoType, this.userId});

  void updateOnly(String userId, String field, value) {
    field = field.toLowerCase();
    if (field == 'height' || field == 'weight') {
      value = double.parse(value);
      print('parsed value is $value');
    }
    if (field == 'name') {
      field = 'displayName';
    }
    // print(userId);
    // print(field);

    try {
      databaseRef.collection('users').document(userId).updateData({
        field: value,
      });
      print("successfully updated!");
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController(text: infoType);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Row(children: [
              Text(
                text,
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(
                width: size.width * 0.07,
              ),
              Container(
                width: size.width * 0.6,
                // decoration: ShapeDecoration(
                //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                // ),
                child: TextFormField(
                    // controller: _controller,
                    initialValue: infoType,
                    cursorColor: kPrimaryColor,
                    onFieldSubmitted: (value) {
                      // print(_controller.text);
                      print('value $value');
                      updateOnly(userId, text, value);
                    }),
              ),
            ]),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            RaisedButton(
              onPressed: () {},
              child: Text('OK'),
              color: kPrimaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
