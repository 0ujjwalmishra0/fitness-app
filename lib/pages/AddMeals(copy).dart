import 'dart:convert';

import 'package:fitness_app/Screens/Meals/MealDetail.dart';
import 'package:fitness_app/constants.dart';
import 'package:fitness_app/models/custom_route.dart';
import 'package:fitness_app/models/food.dart';
import 'package:fitness_app/models/nutrient.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class AddMeals extends StatefulWidget {
  static const routeName = '/AddMealsPage';

  @override
  _AddMealsState createState() => _AddMealsState();
}

class _AddMealsState extends State<AddMeals> {
  List<FoodResult> searchedFood = [];

  // List<Food> searchedFood = [];
  List<Nutrient> nutri = [];
  TextEditingController searchController = TextEditingController();

  searchApi(String query) async {
    final apiKey = 'FDih56yE2SNCMqPMN9GO2obTYBAsvZO8LVwClfqK';
    var url =
        'https://api.nal.usda.gov/fdc/v1/foods/search?api_key=${apiKey}&query=${query}';
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');

    if (response.statusCode != 200) {
      print("Could not find");
    } else {
      // Food data = Food.fromJson(json.decode(response.body));
      // print("total pages is: ");
      var myResponse = json.decode(response.body);
      var food = myResponse['foods'];
      food.forEach((item) {
        Food data = Food.fromJson(item);
        FoodResult foodResult = FoodResult(data);
        // searchedFood.add(data);
        searchedFood.add(foodResult);
      });
    }
  }

  AppBar buildSearchField() {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      elevation: 3,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.qr_code_scanner_rounded,
            color: kPrimaryColor,
          ),
          onPressed: () {},
        ),
        SizedBox(
          width: 5,
        )
      ],
      title: TextFormField(
          controller: searchController,
          // enableInteractiveSelection: ,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search for food',
            hintStyle: TextStyle(height: 1.49),

            // filled: true,
            prefixIcon: Icon(Icons.search),
            suffixIcon: searchController.text.isEmpty
                ? null
                : IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () => searchController.clear(),
                  ),
          ),
          // onFieldSubmitted:
          onFieldSubmitted: (_) {
            // searchedFood.add(searchController.text);
            // searchedFood.clear();
            searchApi(searchController.text);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildSearchField(),
      body: ListView(
        children: searchedFood.toList(),
      ),
      // ListView.builder(
      //     itemBuilder: (context, index) => buildSearchText(index)),
    );
  }

////////////////////////START HERE/////////////////////////////////////

//   buildSearchText(int index) {
//     if (index < searchedFood.length - 1) {
//       // print(searchedFood[index].nutrients.elementAt(3));
//       final energy = searchedFood[index]
//           .nutrients
//           .where((element) => element.name == 'Energy');
//       return ListTile(
//         title: Text(searchedFood[index].name),
//         subtitle: Text(energy.toString()),
//         trailing: Icon(
//           Icons.add,
//           color: kPrimaryColor,
//         ),
//       );
//     }
//   }
}

class FoodResult extends StatefulWidget {
  final Food food;
  FoodResult(this.food);

  @override
  _FoodResultState createState() => _FoodResultState();
}

class _FoodResultState extends State<FoodResult> {
  var foodBox;
  @override
  void initState() {
    super.initState();
    // open();
  }

  // open() async {
  //   Hive.registerAdapter(FoodAdapter());
  //   foodBox = await Hive.openBox<Food>('food');
  // }

  @override
  Widget build(BuildContext context) {
    final energy =
        widget.food.nutrients.where((element) => element.name == 'Energy');

    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              print('tapped! ${widget.food.id}');
              Navigator.of(context).push(CustomRoute(
                  builder: (ctx) => MealDetail(mealfood: widget.food)));
              // foodBox.put('food', widget.food);
              print('food name is: ${widget.food.name}');
            },
            child: ListTile(
              title: Text(
                widget.food.name,
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(energy.toString()),
            ),
          ),
        ],
      ),
    );
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   foodBox.close();
  // }
}
