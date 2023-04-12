import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';



class chartDataPilates{
  final String time;
  final String date;

  chartDataPilates(this.time, this.date);
}


class scatterChartPilates extends StatefulWidget {
  const scatterChartPilates({Key? key}) : super(key: key);

  @override
  State<scatterChartPilates> createState() => _scatterChartPilatesState();
}

class _scatterChartPilatesState extends State<scatterChartPilates> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Pilates').orderBy('dateTime').snapshots(),
        builder: (BuildContext context, AsyncSnapshot pilatessnapshot){

          List<chartDataPilates> data_Running = [];
          if (pilatessnapshot.hasData ) {
            for (int index = 0; index < pilatessnapshot.data?.docs.length; index++) {
              DocumentSnapshot documentSnapshot = pilatessnapshot.data?.docs[index];
              data_Running.add(chartDataPilates(documentSnapshot['Time'], documentSnapshot['dateTime'].toString()));
            }
          }
          return new SfCartesianChart(
              title: ChartTitle(text: 'Pilates workout', textStyle: TextStyle(fontWeight: FontWeight.bold)),
              primaryXAxis: CategoryAxis(),
              primaryYAxis: CategoryAxis(),
              series: <ChartSeries>[
                // Renders scatter chart
                ScatterSeries<chartDataPilates, String>(
                  dataSource: data_Running,
                  xValueMapper: (chartDataPilates data, _) => data.date,
                  yValueMapper: (chartDataPilates data, _) => int.tryParse(data.time),
                )
              ]
          );
        } ,
      ),
    );
  }
}
