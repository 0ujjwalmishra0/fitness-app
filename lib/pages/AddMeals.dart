import 'package:flutter/material.dart';

class AddMeals extends StatelessWidget {
  static const routeName = '/AddMealsPage';

  TextEditingController searchController = TextEditingController();
  AppBar buildSearchField() {
    return AppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
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
        onFieldSubmitted: null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildSearchField(),
    );
  }
}
