import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';



class chartDataRunning{
  final String time;
  final String distance;

  chartDataRunning(this.time, this.distance);
}


class scatterChartRunning extends StatefulWidget {
  const scatterChartRunning({Key? key}) : super(key: key);

  @override
  State<scatterChartRunning> createState() => _scatterChartRunningState();
}

class _scatterChartRunningState extends State<scatterChartRunning> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Running').orderBy('dateTime').snapshots(),
        builder: (BuildContext context, AsyncSnapshot runningsnapshot){

          List<chartDataRunning> data_Running = [];
          if (runningsnapshot.hasData ) {
            for (int index = 0; index < runningsnapshot.data?.docs.length; index++) {
            DocumentSnapshot documentSnapshot = runningsnapshot.data?.docs[index];
            data_Running.add(chartDataRunning(documentSnapshot['Time'], documentSnapshot['Distance']));
            }
            }
            return new SfCartesianChart(
                title: ChartTitle(text: 'Running workout', textStyle: TextStyle(fontWeight: FontWeight.bold)),
                primaryXAxis: CategoryAxis(),
                primaryYAxis: CategoryAxis(),
                series: <ChartSeries>[
                  // Renders scatter chart
                  ScatterSeries<chartDataRunning, String>(
                      dataSource: data_Running,
                      xValueMapper: (chartDataRunning data, _) => data.time,
                      yValueMapper: (chartDataRunning data, _) => int.tryParse(data.distance),
                      markerSettings: MarkerSettings(
                         color: Colors.redAccent,
                          height: 10,
                          width: 10,
                          // Scatter will render in diamond shape
                          shape: DataMarkerType.diamond
                      )
                  )
                ]
            );
          } ,
      ),
    );
  }
}
