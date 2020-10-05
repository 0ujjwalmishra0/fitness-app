import 'package:fitness_app/Screens/Meals/AddMeals.dart';
import 'package:fitness_app/constants.dart';
import 'package:fitness_app/models/auth.dart';
import 'package:fitness_app/models/custom_route.dart';
import 'package:fitness_app/models/food.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final foodRef = Firestore.instance.collection('foods');

class ShowMeal extends StatefulWidget {
  String mealType;
  String uid;
  ShowMeal({this.mealType, this.uid});

  @override
  _ShowMealState createState() => _ShowMealState();
}

class _ShowMealState extends State<ShowMeal> {
  QuerySnapshot foods;
  @override
  void initState() {
    getData().then((result) {
      setState(() {
        foods = result;
      });
    });
    super.initState();
  }

  getData() async {
    return await foodRef.document(widget.uid).collection('food').getDocuments();
    // .then((value) => value.documents.forEach((element) {
    //       print(element.data);
    //     }));
  }

  Widget foodList() {
    if (foods != null) {
      return ListView.builder(
          itemCount: foods.documents.length,
          itemBuilder: (context, index) {
            // return ListTile(
            //   title: Text(foods.documents[index].data['name']),

            // );
            return ExpansionTile(
              title: ListTile(title: Text(foods.documents[index].data['name']),),
              trailing: Icon(Icons.arrow_drop_down_circle),
              children: <Widget>[
                Column(
                  children: [
                    ListTile(
                      title: Text('Energy'),
                      trailing: Text(
                          foods.documents[index].data['energy'].toString()+" kcal"),
                    ),
                    ListTile(
                      title: Text('Protein'),
                      trailing: Text(
                          foods.documents[index].data['protein'].toString()+" g"),
                    ),
                    ListTile(
                      title: Text('Carbohydrate'),
                      trailing: Text(
                          foods.documents[index].data['carbohydrate'].toString()+" g"),
                    ),
                    ListTile(
                      title: Text('Fats'),
                      trailing: Text(
                          foods.documents[index].data['fats'].toString()+" g"),
                    ),
                    ListTile(
                      title: Text('Sugar'),
                      trailing: Text(
                          foods.documents[index].data['sugar'].toString()+" g"),
                    ),
                  ],
                ),
              ],
              initiallyExpanded: false,
            );
          });
    } else {
      Center(child: CircularProgressIndicator());
    }
  }

  @override
  Widget build(BuildContext context) {
    // getLocalData();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: foodList(),
      // FutureBuilder(
      //     future: getData(),
      //     builder: (context, snapshot) {
      //       if (!snapshot.hasData) {
      //         return Center(child: CircularProgressIndicator());
      //       } else {

      //         //   return ListView(
      //         //     children: snapshot.data.documents.map((doc) {
      //         //       return Container(
      //         //         width: size.width/1.2,
      //         //         // height: size.height/1.2,
      //         //         child: Text(doc['name']),
      //         //       );
      //         //     }).toList(),
      //         //   );
      //         // }
      //         // switch (snapshot.connectionState) {

      //         //   case ConnectionState.waiting:
      //         //     return Center(child: CircularProgressIndicator());
      //         //     break;
      //         //   default:
      //         //     return ListView.builder(
      //         //       itemCount: snapshot.size,
      //         //       itemBuilder: (ctx, index) {
      //         //         return Text(snapshot.data[index]);
      //         //       },
      //         //     );
      //       }
      //     }),

      // Column(
      //   children: [
      //     Text(widget.mealType),
      //     Text(uid ?? 'null'),
      //   ],
      // ),

      bottomNavigationBar: Container(
        height: size.height * 0.065,
        child: RaisedButton(
          onPressed: () {
            Navigator.of(context)
                .pushReplacement(CustomRoute(builder: (ctx) => AddMeals()));
          },
          child: Text(
            'Add',
            style: TextStyle(color: Colors.white),
          ),
          color: kPrimaryColor,
        ),
      ),
    );
  }
}
