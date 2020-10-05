import 'dart:io';

import 'package:fitness_app/models/food.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tableName = "foods";
final String Column_id = "id";
final String Column_name = "name";

class DBProvider {
  
  static Database _database;
  Database db;

  DBProvider() {
    // initDB();
    initDatabase();
  }

// if instance exist return
// else return new instance
  Future<Database> get database async {
    if (_database != null) return _database;

    //if database is null we instantiate it
    _database = await initDB();
    // _database = await initDatabase();
    return _database;
  }

  initDatabase() async {
    db = await openDatabase(join(await getDatabasesPath(), "foodDB.db"),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE $tableName($Column_id INTEGER PRIMARY KEY AUTOINCREMENT, $Column_name TEXT)");
    }, version: 1);
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationSupportDirectory();
    String path = join(documentsDirectory.path, "foodDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, version) async {
      await db.execute("CREATE TABLE foods ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          ")");
    });
  }

  addFood(Food newFood) async {
    final db = await database;
    var res = await db.insert("foods", newFood.toMap());
    return res;
  }

  Future<void> insertFood(Food food) async {
    try {
      db.insert(
        tableName,
        food.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print(e);
    }
  }

  getFood(int id) async {
    final db = await database;
    var res = await db.query("foods", where: "id= ?", whereArgs: [id]);
    return res.isNotEmpty ? Food.fromMap(res.first) : null;
  }

  getAllFoods() async {
    final db = await database;
    var res = await db.query("foods");
    List<Food> list =
        res.isNotEmpty ? res.map((e) => Food.fromMap(e)).toList() : [];
    return list;
  }

  updateClient(Food newFood) async {
    final db = await database;
    var res = await db.update("Client", newFood.toMap(),
        where: "id = ?", whereArgs: [newFood.id]);
    return res;
  }

  deleteFood(int id) async {
    final db = await database;
    db.delete("foods", where: "id= ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from foods");
  }
}

//  // Define a function that inserts dogs into the database
// Future<void> insertFood(Food food,Database database) async {
//   // Get a reference to the database.
//   final Database db = await database;

//   // Insert the Dog into the correct table. You might also specify the
//   // `conflictAlgorithm` to use in case the same dog is inserted twice.
//   //
//   // In this case, replace any previous data.
//   await db.insert(
//     'foods',
//     food.toMap(),
//     conflictAlgorithm: ConflictAlgorithm.replace,
//   );
// }

// // A method that retrieves all the dogs from the dogs table.
// Future<List<Food>> foods(Database database) async {
//   // Get a reference to the database.
//   final Database db = await database;

//   // Query the table for all The Dogs.
//   final List<Map<String, dynamic>> maps = await db.query('dogs');

//   // Convert the List<Map<String, dynamic> into a List<Dog>.
//   return List.generate(maps.length, (i) {
//     return Food(
//       id: maps[i]['id'],
//       name: maps[i]['name'],
//       nutrients: maps[i]['nutrients'],
//     );
//   });
// }

// Future<void> updateDog(Food food,Database database) async {
//   // Get a reference to the database.
//   final db = await database;

//   // Update the given Food.
//   await db.update(
//     'foods',
//     food.toMap(),
//     // Ensure that the Food has a matching id.
//     where: "id = ?",
//     // Pass the Food's id as a whereArg to prevent SQL injection.
//     whereArgs: [food.id],
//   );
// }

// Future<void> deleteDog(int id,Database database) async {
//   // Get a reference to the database.
//   final db = await database;

//   // Remove the Food from the Database.
//   await db.delete(
//     'foods',
//     // Use a `where` clause to delete a specific food.
//     where: "id = ?",
//     // Pass the Food's id as a whereArg to prevent SQL injection.
//     whereArgs: [id],
//   );
// }
