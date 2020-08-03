import 'package:fitness_app/models/custom_route.dart';
import 'package:fitness_app/pages/AddMeals.dart';
import 'package:flutter/material.dart';

class Meals extends StatelessWidget {
  Row showTotalCalorie() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: <Widget>[
            Text('Protein'),
            Text('31g'),
          ],
        ),
        Column(
          children: <Widget>[
            Text('Fats'),
            Text('31g'),
          ],
        ),
        Column(
          children: <Widget>[
            Text('Carbs'),
            Text('31g'),
          ],
        ),

        //space between nutrients and colorie
        SizedBox(
          width: 4,
        ),

        Column(
          children: <Widget>[
            Text('Calorie'),
            Text('900k'),
          ],
        ),
      ],
    );
  }

  Widget selectMeal(String mealType, String description,BuildContext context) {
    description = description.isEmpty ? 'No meal added yet' : description;
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(top: 10),
      color: Colors.pink,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(mealType),
                Row(
                  children: <Widget>[
                    Text('0 of 450kcal'),
                    IconButton(icon: Icon(Icons.add_circle), 
                    onPressed: () {
                      Navigator.of(context)
        .push(CustomRoute(builder: (ctx) => AddMeals()));
}),
                  ],
                )
              ],
            ),
            // Text(''),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meals'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Text('Daily Calories', style: TextStyle(fontSize: 40)),
            showTotalCalorie(),
            selectMeal('Breakfast', 'apple',context),
            selectMeal('Lunch', '',context),
            selectMeal('Evening Snack', '',context),
            selectMeal('Dinner', 'roti sabzi',context),
          ],
        ),
      ),
    );
  }
}
