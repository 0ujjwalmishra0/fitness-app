import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MealInfo extends StatelessWidget {
  Row displayMacros() {
    return Row(
      children: <Widget>[
        Column(children: <Widget>[
          Text('Proteins'),
          Text('0.6g'),
        ],),
        Column(children: <Widget>[
          Text('Carbs'),
          Text('0.6g'),
        ],),
        Column(children: <Widget>[
          Text('Fats'),
          Text('0.6g'),
        ],),
        Column(children: <Widget>[
          Text('Fiber'),
          Text('0.6g'),
        ],),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          CachedNetworkImage(
              imageUrl:
                  "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pexels.com%2Fsearch%2Fapple%2F&psig=AOvVaw04H8i08bNAJcrFnb7Ec3MM&ust=1596426889601000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCIi4k-DP--oCFQAAAAAdAAAAABAD"),
          Text('Pick the quantity of Food'),
          Text(' 0.25              grams'),
          Text('Nutritional Informaiton'),

          FloatingActionButton(onPressed: (){},child: Icon(Icons.add),)
        ],
      ),
    );
  }
}
