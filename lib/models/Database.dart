import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sql.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'user.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

// if instance exist return
// else return new instance
  Future<Database> get database async {
    return _database;
  }

  initDB() async {
    return await openDatabase(
      // join method from path package
      join(await getDatabasesPath(), 'profile_info.db'),
      onCreate: (db, version) async {
        await db.execute(''' 
        CREATE TABLE users(
          displayName text,
          email text  primary key,
          age int,
          weight float,
          height float,
          sex text,
          photoUrl text,
        )

        ''');
      },
      version: 1,
    );
  }

  newUser(User newUser) async {
    final db = await database;
    var response = await db.rawInsert('''
      INSERT INTO users(
        displayName, email, age, weight, height, sex,photoUrl
      ) VALUES(?,?)
     ''', [
      newUser.displayName,
      newUser.email,
      newUser.age,
      newUser.weight,
      newUser.height,
      newUser.sex,
      newUser.photoUrl
    ]);
    return response;
  }

  Future<dynamic> getUser() async {
    final db = await database;
    final response = await db.query("users");
    if (response.length == 0) {
      return null;
    } else {
      var resMap = response[0];
      return resMap.isNotEmpty ? resMap : null;
    }
  }
}
