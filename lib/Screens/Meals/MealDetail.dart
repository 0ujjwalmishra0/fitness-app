import 'package:flutter/material.dart';
import '../../models/food.dart';

class MealDetail extends StatefulWidget {
  final Food mealfood;
  final String name;
  MealDetail({this.mealfood, this.name});

  @override
  _MealDetailState createState() => _MealDetailState();
}

class _MealDetailState extends State<MealDetail> {
  TextEditingController _quantity = TextEditingController();
  var newfood;
  double multiplier;
  buildQuantity() {
    return TextFormField(
        autofocus: true,
        controller: _quantity,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Quantity',
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
      print(value);
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

    final height = MediaQuery.of(context).size.height;

    final protein = (widget.mealfood.nutrients[8]);
    final fats = (widget.mealfood.nutrients[0]);
    final carbohydrate = (widget.mealfood.nutrients[9]);
    final fiber = (widget.mealfood.nutrients[10]);
    final sugar = (widget.mealfood.nutrients[11]);

    return Scaffold(
      appBar: AppBar(
        title: Text('Nutritional Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 15),
        child: Column(
          children: [
            Text('Pick the quantity of Food'),
            buildQuantity(),
            SizedBox(height: height*0.05),
            Text('Nutritional Information'),
            SizedBox(height: height*0.04),
            buildInfo(protein),
            buildInfo(fats),
            buildInfo(carbohydrate),
            buildInfo(sugar),
            buildInfo(fiber),
          ],
        ),
      ),
    );
  }
}
