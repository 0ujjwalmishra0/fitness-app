import 'package:fitness_app/constants.dart';
import 'package:fitness_app/models/Database1.dart';
import 'package:fitness_app/models/auth.dart';
import 'package:fitness_app/models/nutrient.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/food.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final foodRef = Firestore.instance.collection('foods');

class MealDetail extends StatefulWidget {
  Food mealfood;
  final String mealType;
  MealDetail({this.mealfood, this.mealType});

  @override
  _MealDetailState createState() => _MealDetailState();
}

class _MealDetailState extends State<MealDetail> {
  TextEditingController _quantity = TextEditingController();
  String uid;
  DBProvider _dbProvider;
  double multiplier;
  Food newFood;
  List<Food> foods = [];

  Nutrient protein;
  Nutrient fats;
  Nutrient carbohydrate;
  Nutrient energy;
  Nutrient sugar;
  @override
  void initState() {
    super.initState();
  }


  final date= DateTime.now().day.toString();
  void createRecord() async {
    await foodRef.document(uid).collection(widget.mealType).add({
      'name': widget.mealfood.name,
      'protein': protein.value,
      'carbohydrate': carbohydrate.value,
      'energy': energy.value,
      'sugar': sugar.value,
      'fats': fats.value,
      'multiplier': multiplier ?? 1,
      'time': DateTime.now(),
    });
  }

  buildQuantity() {
    return TextFormField(
      
        autofocus: true,
        controller: _quantity,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Quantity (gm)',
          hintStyle: TextStyle(color: kPrimaryColor),
          suffixIcon: _quantity.text.isEmpty
              ? null
              : IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _quantity.clear();
                    //on clearing multiplier quantity, we need to restore values
                    // thus make multiplier null, and check it in buildInfo()
                    setState(() {
                      multiplier = null;
                    });
                  },
                ),
        ),
        onFieldSubmitted: (val) {
          setState(() {
            multiplier = double.parse(val);
            print('multiplier is $multiplier');
          });

          // handleQuantity(multiplier);
        });
  }

  buildInfo(nutrient) {
    var value = nutrient.value;
    if (multiplier != null) {
      value = value * multiplier;
    } else {
      //if multiplier is null, restore values to original value
      value = nutrient.value;
      print(nutrient.name);
      // print(value);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(nutrient.name),
          Text('${value.toStringAsFixed(2)} ${nutrient.unit}'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /****  PRINT ALL THE NUTRIENT OF FOOD */

    //  widget.mealfood.nutrients.forEach((element) {
    //   print(element.name);
    // });
    final user = Provider.of<Auth>(context, listen: false);
    user.getCurrenUser().then((id) => uid = id);
    final height = MediaQuery.of(context).size.height;

    protein = (widget.mealfood.nutrients[8]);
    fats = (widget.mealfood.nutrients[0]);
    carbohydrate = (widget.mealfood.nutrients[9]);
    energy = (widget.mealfood.nutrients[10]);
    sugar = (widget.mealfood.nutrients[11]);

    return Scaffold(
      appBar: AppBar(
        title: Text('Nutritional Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 15),
        child: Column(
          children: [
            Text(widget.mealfood.name),
            SizedBox(height: 20,),
            Text('Pick the quantity of Food'),
            buildQuantity(),
            SizedBox(height: height * 0.05),
            Text('Nutritional Information'),
            SizedBox(height: height * 0.04),
            buildInfo(protein),
            buildInfo(fats),
            buildInfo(carbohydrate),
            buildInfo(sugar),
            buildInfo(energy),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  onPressed: () async {
                    newFood = Food(name: widget.mealfood.name);
                    print(newFood.name);
                    await _dbProvider.addFood(newFood);
                  },
                  child: Text('Add'),
                ),
                RaisedButton(
                  onPressed: () async {
                    //TODO:ADD food to firestore
                    createRecord();

                    //TODO: ADD food to sql
                    // List<Food> myFoods = await _dbProvider.getAllFoods();

                    // myFoods.forEach((element) {
                    //   print(element);
                    // });
                  },
                  child: Text('Add to cloud'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
