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
final currTime = DateTime.now().day;
// final DateFormat formatter = DateFormat('yyyy-MM-dd');
// final String currDate = formatter.format(now);

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
        .collection('Breakfast')
        .where('time', isLessThanOrEqualTo: DateTime.now().day)
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
  double res = 0;
  List graph = [];
  List graphDate = [];
  var uniqueDate = <int>{};
  calcEnergy() {
    for (var i = 0; i < foods.documents.length; i++) {
      uniqueDate.add(foods.documents[i].data['time']);
    }

    print(uniqueDate.length);

    for (var j = 0; j < uniqueDate.length; j++) {
      for (var i = 0; i < foods.documents.length; i++) {
        if (foods.documents[i].data['time'] == (currTime - j)) {
          res += (foods.documents[i].data['energy'] *
              foods.documents[i].data['multiplier']);
        }

        // print(res);
      }

      graph.add(res);
      graphDate.add(currTime - j);
      res = 0;
    }

    // print('res is $res');
    print(graph);
    print(graphDate);
    // res = 0;


    setState(() {});
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
    List<FoodData> foodData = [];
    // for (var i = 0; i < graph.length; i++) {
    //   foodData.add(FoodData(day: graphDate[i].toString(), cal: graph[i]));
    // }
for (var i = graph.length-1; i>=0; i--) {
      foodData.add(FoodData(day: graphDate[i].toString(), cal: graph[i]));
    }
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text('Graph'),
      ),
      body: Center(
        // child: showInformation(name, desc),
        child: Container(
          height: 400,
          width: 350,
          // child:  _getDefaultPieChart(),
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(
              majorGridLines: MajorGridLines(width: 0),
            ),
            primaryYAxis: NumericAxis(
          axisLine: AxisLine(width: 0),
          labelFormat: '{value}',
          majorTickLines: MajorTickLines(size: 0)),
      tooltipBehavior:TooltipBehavior(enable: true, header: '', canShowMarker: false),
            title: ChartTitle(text: 'Energy(cal)'),
            // legend: Legend(isVisible: true),
            series: <ColumnSeries<FoodData, String>>[
              // Initialize line series.
              ColumnSeries<FoodData, String>(
                  dataSource: foodData,
                  xValueMapper: (FoodData food, _) => food.day,
                  yValueMapper: (FoodData food, _) => food.cal,
                  dataLabelMapper: (FoodData data, _) => data.text,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                  width: 0.2,
                  spacing: 0.0,
                  
                  ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh_rounded),

        onPressed: calcEnergy,
        // scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  /// Returns the circular  chart with pie series.
  SfCircularChart _getDefaultPieChart() {
    return SfCircularChart(
      // title: ChartTitle(text: isCardView ? '' : 'Sales by sales person'),
      // legend: Legend(isVisible: !isCardView),
      series: _getDefaultPieSeries(),
    );
  }

  /// Returns the pie series.
  List<PieSeries<FoodData, String>> _getDefaultPieSeries() {
    final List<FoodData> pieData = <FoodData>[
      FoodData(day: 'David', cal: 30, text: 'Protein \n 30%'),
      FoodData(day: 'Steve', cal: 35, text: 'Carbs \n 35%'),
      FoodData(day: 'Jack', cal: 39, text: 'Fats \n 39%'),
      FoodData(day: 'Others', cal: 75, text: 'Cal \n 75%'),
    ];
    return <PieSeries<FoodData, String>>[
      PieSeries<FoodData, String>(
          explode: true,
          explodeIndex: 0,
          explodeOffset: '10%',
          dataSource: pieData,
          xValueMapper: (FoodData data, _) => data.day,
          yValueMapper: (FoodData data, _) => data.cal,
          dataLabelMapper: (FoodData data, _) => data.text,
          startAngle: 90,
          endAngle: 90,
          dataLabelSettings: DataLabelSettings(isVisible: true)),
    ];
  }
}

class FoodData {
  FoodData({this.day, this.cal, this.text});
  final String day;
  final double cal;
  final String text;
}
