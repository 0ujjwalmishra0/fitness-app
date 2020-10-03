import 'package:fitness_app/models/nutrient.dart';
import 'dart:typed_data';
import 'package:hive/hive.dart';

part 'food.g.dart';

@HiveType(typeId: 0)
class Food {
  int id;
  String name;
  String foodGroupImage;
  String foodGroup;
  Uint8List matchinfo;
  bool favourite;
  int totalPages;
  @HiveField(1)
  List<Nutrient> nutrients;

  // final Nutrient protein;
  // final Nutrient totalSugars;
  // final Nutrient fat;
  // final Nutrient carbohydrate;
  // final Nutrient energy;
  // final Nutrient dietaryFiber;

  String get imagePath {
    return "images/$foodGroupImage.jpg";
  }

  Food(
      {this.id,
      this.name,
      this.nutrients,
      this.foodGroup,
      this.foodGroupImage,
      this.matchinfo,
      this.favourite,
      this.totalPages,
      num proteinValue,
      num totalSugarsValue,
      num fatValue,
      num carbohydrateValue,
      num energyValue,
      num dietaryFiberValue});
  // : totalSugars = Nutrient("Total Sugars", totalSugarsValue),
  //   carbohydrate = Nutrient(
  //     "Carbohydrate",
  //     carbohydrateValue,
  //   ),
  //   fat = Nutrient(
  //     "Total Fat",
  //     fatValue,
  //   ),
  //   energy = Nutrient(
  //     "Energy",
  //     energyValue,
  //   ),
  //   protein = Nutrient("Protein", proteinValue),
  //   dietaryFiber = Nutrient("Dietary Fiber", dietaryFiberValue);

  // factory Food.fromJson(Map<String, dynamic> json) {
  //   var nutrientsJson = json['foodNutrients'] as List;
  //   List<Nutrient> nutrients = nutrientsJson != null
  //       ? nutrientsJson.map((i) => Nutrient.fromJson(i)).toList()
  //       : null;

  //   return new Food(
  //       id: json["id"],
  //       name: json["description"],
  //       foodGroup: json["food_group"],
  //       foodGroupImage: json["food_group_image"],
  //       matchinfo: json["matchinfo"],
  //       proteinValue: json["protein"],
  //       totalSugarsValue: json["total_sugars"],
  //       carbohydrateValue: json[''],
  //       fatValue: json[''],
  //       energyValue: json['foodNutrients'][10],
  //       dietaryFiberValue: json["dietaryFiber"],
  //       favourite: json["favourite"] == 1,
  //       totalPages: json["totalPages"],
  //       nutrients: nutrients,
  //       );
  // }

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "description": name,
  //       "food_group": foodGroup,
  //       "food_group_image": foodGroupImage,
  //       "favourite": favourite ? 1 : 0,
  //       "protein": protein.value,
  //       "total_sugars": totalSugars.value,
  //       "fat": fat.value,
  //       "": carbohydrate.value,
  //       "": energy.value,
  //       "dietary_fiber": dietaryFiber.value
  //     };

  // Food _foodFromJson(Map<String, dynamic> json) {
  //   var nutrientsJson = json['foodNutrients'] as List;
  //   List<Nutrient> nutrients = nutrientsJson != null
  //       ? nutrientsJson.map((i) => Nutrient.fromJson(i)).toList()
  //       : null;

  //   return Food(
  //     id: json['fdcId'],
  //     name: json['description'],
  //     nutrients: nutrients,
  //   );
  // }

  factory Food.fromJson(Map<String, dynamic> json) {
    var nutrientsJson = json['foodNutrients'] as List;
    List<Nutrient> nutrients = nutrientsJson != null
        ? nutrientsJson.map((i) => Nutrient.fromJson(i)).toList()
        : null;

    return new Food(
      id: json["fdcId"],
      name: json["description"],
      nutrients: nutrients,
    );
  }
}
