import 'dart:convert';

User userfromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data);

class User {
  String displayName;
  String email;
  String photoUrl;
  int height;
  int weight;
  int age;
  String sex;
  User({
    this.displayName,
    this.email,
    this.height,
    this.photoUrl,
    this.weight,
    this.age,
    this.sex,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
      'height': height,
      'weight': weight,
      'age': age,
      'sex': sex,
    };
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    displayName = map['displayName'];
    email = map['email'];
    photoUrl = map['photoUrl'];
    height = map['height'];
    weight = map['weight'];
    age = map['age'];
    sex = map['sex'];
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        displayName: json['displayName'],
        email: json['email'],
        photoUrl: json['photoUrl'],
        height: json['height'],
        weight: json['weight'],
        age: json['age'],
        sex: json['sex'],
      );
}
