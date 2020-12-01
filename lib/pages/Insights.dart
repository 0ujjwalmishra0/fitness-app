import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:fitness_app/pages/dummy.dart';

import 'package:fitness_app/models/custom_route.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

final foodRef = Firestore.instance.collection('foods');

class Insights extends StatefulWidget {
  String uid;
  Insights(this.uid);
  @override
  _InsightsState createState() => _InsightsState();
}

class _InsightsState extends State<Insights> {
  var foods;

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
    return await foodRef
        .document(widget.uid)
        .collection('Lunch')
        .getDocuments();
  }

  var result = "Hey there !";
  String name;
  String desc;
  int carb;
  int protein;
  int fat;
  int calorie;
  int sugar;
  int fats;
  bool status;
  List<FoodData> foodList = [];
  double totalEnergy = 0;

  calcEnergy() {
    double res = 0;

    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String currDate = formatter.format(now);

    for (var i = 0; i < foods.documents.length; i++) {
      res += (foods.documents[i].data['energy']);

      int timeInMillis = foods.documents[i].data['time'].seconds;
      var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
      var formattedDate = DateFormat.yMd().format(date);
      print(formattedDate);
      print(currDate);
      // if (currDate == formattedDate) {
      //   print("yes");
      // } else {
      //   print("false");
      // }
    }
    print(res);
  }

  _launchURL(String url) async {
    // const url = 'https://flutter.dev';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  getApi(String qr) async {
    var url =
        'https://api.nutritionix.com/v1_1/item?upc=${qr}&appId=e1c2be09&appKey=8f6ba49fa42d2696ce5b65b6495a981d';
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');

    if (response.statusCode != 200) {
      print("Could not find");
    } else {
      print('successful');
      print('Response body: ${response.body}');
    }
    Map<String, dynamic> user = jsonDecode(response.body);
    setState(() {
      name = user['item_name'];
      desc = user['item_description'];
      calorie = user['nf_calories'];
      carb = user['nf_total_carbohydrate'];
      protein = user['nf_protein'];
      fats = user['nf_total_fat'];
      sugar = user['nf_sugars'];
    });

    print('name: ${user['item_name']}!');
    print('description: ${user['item_description']}');
  }

  Future scanQR() async {
    try {
      var qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult.rawContent;
        print(qrResult);
        getApi(result);
      });
      _launchURL(result);
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });
    }
  }

  Widget showInformation(String name, String desc) {
    return status == false
        ? Text(
            "Could not find the item",
            style: new TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
          )
        : Column(
            children: <Widget>[
              Text(
                name == null ? '' : 'name: ${name}',
                style:
                    new TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
              ),
              Text(
                desc == null ? '' : 'description: ${desc}',
                style:
                    new TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
              ),
              Text(
                name == null ? '' : 'carb: ${carb}',
                style:
                    new TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
              ),
              Text(
                desc == null ? '' : 'fats: ${fats}',
                style:
                    new TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
              ),
              Text(
                name == null ? '' : 'calorie: ${calorie}',
                style:
                    new TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
              ),
              Text(
                desc == null ? '' : 'protein: ${protein}',
                style:
                    new TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
              ),
              Text(
                desc == null ? '' : 'sugar: ${sugar}',
                style:
                    new TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
              ),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
      ),
      body: Center(
        // child: showInformation(name, desc),
        child: Container(
          height: 400,
          width: 300,
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            title: ChartTitle(text: 'data'),
            // legend: Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <LineSeries<FoodData, String>>[
              // Initialize line series.
              LineSeries<FoodData, String>(
                  dataSource: [
                    FoodData('Jan', 35),
                    FoodData('Feb', 28),
                    FoodData('Mar', 34),
                    FoodData('Apr', 32),
                    FoodData('May', 40)
                  ],
                  xValueMapper: (FoodData food, _) => food.day,
                  yValueMapper: (FoodData food, _) => food.cal,
                  dataLabelSettings: DataLabelSettings(isVisible: true)),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        label: Text("Scan"),
        onPressed: calcEnergy,
        // scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class FoodData {
  FoodData(this.day, this.cal);
  final String day;
  final double cal;
}
