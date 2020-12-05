import 'package:fitness_app/Screens/Meals/showMeal.dart';
import 'package:fitness_app/components/app_drawer.dart';
import 'package:fitness_app/constants.dart';
import 'package:fitness_app/models/custom_route.dart';
import 'package:fitness_app/Screens/Meals/AddMeals.dart';
import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Meals extends StatelessWidget {
  String uid;
  Meals(this.uid);
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
            Text('900 cal'),
          ],
        ),
      ],
    );
  }

  Widget buildCard(
      String title, String description, String imgSrc, BuildContext context) {
    // double defaultSize = SizeConfig.defaultSize;
    // description = description.isEmpty ? 'No meal added yet' : description;
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(CustomRoute(builder: (ctx) => ShowMeal(mealType: title,uid: uid,)));
      },
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        height: 190,
        // defaultSize*19, // 190,
        width: 330,
        // defaultSize*35, //330,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(
            18,
            // SizeConfig.defaultSize * 1.8
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Spacer(),
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 24,
                          // SizeConfig.defaultSize * 2.2, //22
                          color: Colors.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    // Text(
                    //   description,
                    //   style: TextStyle(fontSize: 16, color: Colors.white54),
                    //   maxLines: 2,
                    //   overflow: TextOverflow.ellipsis,
                    // ),
                  ],
                ),
              ),
            ),
            AspectRatio(
              aspectRatio: 0.71,
              child: Image.asset(
                imgSrc,
                fit: BoxFit.cover,
                alignment: Alignment.centerLeft,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return Scaffold(
      appBar: buildAppBar(defaultSize),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 25.0,
          right: 25,
          top: 10,
          bottom: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10,),
              Text('Daily Calories', style: TextStyle(fontSize: 40)),
              showTotalCalorie(),
              buildCard('Breakfast', '', 'assets/images/image_1.png', context),
              buildCard('Lunch', '', 'assets/images/image_2.png', context),
              buildCard('Dinner', '', 'assets/images/cook_new@2x.png', context),
              // buildCard('Breakfast','', 'assets/images/image_1.png',defaultSize),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(double defaultSize) {
    return AppBar(
      brightness: Brightness.dark,
      // leading: IconButton(
      //   icon: SvgPicture.asset("assets/icons2/menu.svg"),
      //   onPressed: () {},
      // ),
      // On Android by default its false
      centerTitle: true,
      title: Image.asset("assets/images/logo.png"),

      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/icons2/search.svg"),
          onPressed: () {},
        ),
        SizedBox(
          // It means 5 because by out defaultSize = 10
          width: 5,
        )
      ],
    );
  }

  Widget selectMeal(String mealType, String description, BuildContext context) {
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
                    Text('0 of 450cal'),
                    IconButton(
                        icon: Icon(Icons.add_circle),
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
}
