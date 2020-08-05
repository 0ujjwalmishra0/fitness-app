import 'package:fitness_app/components/rounded_button.dart';
import 'package:fitness_app/components/text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/constants.dart';

class BasicInformation extends StatelessWidget {
  Widget buildBasicInformation(String text, IconData icon, Size size) {
    return Row(
      children: <Widget>[
        Icon(icon),
        SizedBox(
          width: size.width * 0.04,
        ),
        TextFieldContainer(
          child: TextField(
            onChanged: null,
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
              buildBasicInformation('Name', Icons.account_circle, size),
              buildChooseGender(size),
              buildBasicInformation('Email', Icons.account_circle, size),

              buildBasicInformation('Age', Icons.account_circle, size),
              buildBasicInformation('Weight', Icons.account_circle, size),
              buildBasicInformation('BMI', Icons.account_circle, size),
              // buildBasicInformation('Name', Icons.account_circle, size),
              
                
              
            ],
          ),
        ),
        
      ),
      bottomNavigationBar: Container(
        height: size.height*0.065,
        child: RaisedButton(
        
                    onPressed: () {},
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
