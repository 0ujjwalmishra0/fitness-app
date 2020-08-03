import 'package:fitness_app/components/listTile.dart';
import 'package:fitness_app/constants.dart';
import 'package:flutter/material.dart';

class AddMeals extends StatefulWidget {
  static const routeName = '/AddMealsPage';

  @override
  _AddMealsState createState() => _AddMealsState();
}

class _AddMealsState extends State<AddMeals> {
  List searchedFood = [];

  TextEditingController searchController = TextEditingController();

  AppBar buildSearchField() {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      elevation: 3,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.camera_alt,
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
        onFieldSubmitted: (_) => searchedFood.add(searchController.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildSearchField(),
      body: ListView.builder(
          itemBuilder: (context, index) => buildSearchText(index)),
      // body: FlatButton(
      //     onPressed: () => print(searchedFood), child: Text('Enter')),
    );
  }

  Widget buildSearchText(int index) {
    if (index < searchedFood.length - 1) {
      
      return ListTile(
        title: Text(searchedFood[index]),
        subtitle: Text('1 slice'),
        trailing: Icon(Icons.add,color: kPrimaryColor,),
        
      );
    }
  }
}
