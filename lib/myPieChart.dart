
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/cupertino.dart';


final legendLabels = <String, String>{
  "Flutter": "Flutter legend",
  "React": "React legend",
  "Xamarin": "Xamarin legend",
  "Ionic": "Ionic legend",
};

final colorList = <Color>[
  const Color(0xfffdcb6e),
  const Color(0xff0984e3),
  const Color(0xfffd79a8),
  const Color(0xffe17055),
  const Color(0xff6c5ce7),
];

final gradientList = <List<Color>>[
  [
    const Color.fromRGBO(135, 0, 9, 1),
    const Color.fromRGBO(250, 134, 242,1),
  ],
  [
    const Color.fromRGBO(255, 98, 0, 1),
    const Color.fromRGBO(253, 183, 119, 1),
  ],
  [
    const Color.fromRGBO(85, 37, 134, 1.0),
    const Color.fromRGBO(181, 137, 214, 1),
  ],
  [
    const Color.fromRGBO(0, 0, 255, 1),
    const Color.fromRGBO(191, 191, 255, 1),
  ],
];


class pieChartDB extends StatefulWidget {
  const pieChartDB({Key? key}) : super(key: key);

  @override
  State<pieChartDB> createState() => _pieChartDBState();
}

class _pieChartDBState extends State<pieChartDB> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Running').snapshots(),
        builder: (BuildContext context, runningsnapshot) {
        return Scaffold(
          body: Center(
            child: StreamBuilder(
              stream:FirebaseFirestore.instance.collection('Swimming').snapshots(),
              builder: (BuildContext context, swimmingsnapshot) {
                return Scaffold(
                  body: Center(
                    child: StreamBuilder(
                        stream:FirebaseFirestore.instance.collection('Bicycling').snapshots(),
                        builder: (BuildContext context, bikingsnapshot){
                        return Scaffold(
                          body: Center(
                            child: StreamBuilder(
                              stream:FirebaseFirestore.instance.collection('Pilates').snapshots(),
                              builder: (BuildContext context, pilatessnapshot){
                                final dataMap1 = <String, double>{
                                  "Running": 0,
                                  "Swimming": 0,
                                  "Biking": 0,
                                  "Pilates": 0,
                                };
                                if (runningsnapshot.hasData) {
                                  for (int index = 0; index < runningsnapshot.data!.docs.length; index++) {
                                    dataMap1["Running"] = dataMap1["Running"]! + 1;
                                  }
                                }
                                if (swimmingsnapshot.hasData) {
                                  for (int index = 0; index < swimmingsnapshot.data!.docs.length; index++) {
                                    dataMap1["Swimming"] = dataMap1["Swimming"]! + 1;
                                  }
                                }
                                if (bikingsnapshot.hasData) {
                                  for (int index = 0; index < bikingsnapshot.data!.docs.length; index++) {
                                    dataMap1["Biking"] = dataMap1["Biking"]! + 1;
                                  }
                                }
                                if (pilatessnapshot.hasData) {
                                  for (int index = 0; index < pilatessnapshot.data!.docs.length; index++) {
                                    dataMap1["Pilates"] = dataMap1["Pilates"]! + 1;
                                  }
                                }
                                return PieChart(
                                  dataMap: dataMap1,
                                  animationDuration: Duration(
                                      milliseconds: 1500),
                                  chartLegendSpacing: 40,
                                  chartRadius: MediaQuery
                                      .of(context)
                                      .size
                                      .width / 3.3,
                                  colorList: colorList,
                                  initialAngleInDegree: 0,
                                  chartType: ChartType.ring,
                                  ringStrokeWidth: 32,
                                  centerText: "Workouts\n distribution",
                                  //centerTextStyle: TextStyle(backgroundColor: Color.fromARGB(0, 0, 0, 0)),
                                  legendOptions: LegendOptions(
                                    showLegendsInRow: false,
                                    legendPosition: LegendPosition
                                        .right,
                                    showLegends: true,
                                    //legendShape: _BoxShape.circle,
                                    legendTextStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  chartValuesOptions: ChartValuesOptions(
                                    showChartValueBackground: true,
                                    showChartValues: true,
                                    showChartValuesInPercentage: true,
                                    showChartValuesOutside: true,
                                    decimalPlaces: 1,
                                  ),
                                  gradientList: gradientList,
                                  // emptyColorGradient: ---Empty Color gradient---
                                );
                              },

                            ),
                          ),
                        );
                      }
                    ),
                  ),

                );
              }            ),
          ),
        );
        }
    );
  }
}
