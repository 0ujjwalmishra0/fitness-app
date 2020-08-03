import 'package:fitness_app/constants.dart';
import 'package:flutter/material.dart';

int selectedRadio;

class Goal extends StatefulWidget {
  @override
  _GoalState createState() => _GoalState();
}

class _GoalState extends State<Goal> {
  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

// Changes the selected value on 'onChanged' click on each radio button
  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  buildRadio(String myGoal,int value) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Goal'),
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              
                  buildRadio('Loose Weight',1),
                  
                  buildRadio('Be Fit',2),
                  
                  buildRadio('Gain Muscle',3),
            ],
          ),
        ));
  }
}
