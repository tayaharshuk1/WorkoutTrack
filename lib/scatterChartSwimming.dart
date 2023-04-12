import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';



class chartDataRunning{
  final String time;
  final String distance;

  chartDataRunning(this.time, this.distance);
}


class scatterChartSwimming extends StatefulWidget {
  const scatterChartSwimming({Key? key}) : super(key: key);

  @override
  State<scatterChartSwimming> createState() => _scatterChartSwimmingState();
}

class _scatterChartSwimmingState extends State<scatterChartSwimming> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Swimming').orderBy('dateTime').snapshots(),
        builder: (BuildContext context, AsyncSnapshot swimmingsnapshot){

          List<chartDataRunning> data_Running = [];
          if (swimmingsnapshot.hasData ) {
            for (int index = 0; index < swimmingsnapshot.data?.docs.length; index++) {
              DocumentSnapshot documentSnapshot = swimmingsnapshot.data?.docs[index];
              data_Running.add(chartDataRunning(documentSnapshot['Time'], documentSnapshot['Distance']));
            }
          }
          return new SfCartesianChart(
              title: ChartTitle(text: 'Swimming workout', textStyle: TextStyle(fontWeight: FontWeight.bold)),
              primaryXAxis: CategoryAxis(),
              primaryYAxis: CategoryAxis(),
              series: <ChartSeries>[
                // Renders scatter chart
                ScatterSeries<chartDataRunning, String>(
                  dataSource: data_Running,
                  xValueMapper: (chartDataRunning data, _) => data.time,
                  yValueMapper: (chartDataRunning data, _) => int.tryParse(data.distance),
                )
              ]
          );
        } ,
      ),
    );
  }
}
