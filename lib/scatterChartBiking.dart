import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';



class chartDataBiking{
  final String time;
  final String distance;

  chartDataBiking(this.time, this.distance);
}


class scatterChartBiking extends StatefulWidget {
  const scatterChartBiking({Key? key}) : super(key: key);

  @override
  State<scatterChartBiking> createState() => _scatterChartBikingState();
}

class _scatterChartBikingState extends State<scatterChartBiking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Bicycling').orderBy('dateTime').snapshots(),
        builder: (BuildContext context, AsyncSnapshot bikingsnapshot){

          List<chartDataBiking> data_Running = [];
          if (bikingsnapshot.hasData ) {
            for (int index = 0; index < bikingsnapshot.data?.docs.length; index++) {
              DocumentSnapshot documentSnapshot = bikingsnapshot.data?.docs[index];
              data_Running.add(chartDataBiking(documentSnapshot['Time'], documentSnapshot['Distance']));
            }
          }
          return new SfCartesianChart(
              title: ChartTitle(text: 'Biking workout', textStyle: TextStyle(fontWeight: FontWeight.bold)),
              primaryXAxis: CategoryAxis(),
              primaryYAxis: CategoryAxis(),
              series: <ChartSeries>[
                // Renders scatter chart
                ScatterSeries<chartDataBiking, String>(
                  dataSource: data_Running,
                  xValueMapper: (chartDataBiking data, _) => data.time,
                  yValueMapper: (chartDataBiking data, _) => int.tryParse(data.distance),
                )
              ]
          );
        } ,
      ),
    );
  }
}
