import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


/// Sample ordinal data type.
class Workout{
  final String month;
  final int count;

  Workout(this.month, this.count);
}

List<charts.Series<Workout, String>> createSampleData() {
  final blue = charts.MaterialPalette.indigo.makeShades(22);
  final lightBlue = charts.MaterialPalette.blue.makeShades(2);



  final workout_ = [
    new Workout('1', 5),
    new Workout('2', 2),
    new Workout('3', 10),
    new Workout('11', 4),
  ];

  return [
    new charts.Series<Workout, String>(
      id: 'e',
      seriesCategory: 'acute',
      domainFn: (Workout sales, _) => sales.month,
      measureFn: (Workout sales, _) => sales.count,
      data: workout_,
      colorFn: (Workout count, _) => blue[1],
    ),
  ];
}



class BarChart extends StatefulWidget {

  const BarChart();

  @override
  State<BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {


  int returnMonth(DateTime date) {
    String month = new DateFormat.MMMM().format(date);
    if (month == 'January') return 1;
    if (month == 'February') return 2;
    if (month == 'March') return 3;
    if (month == 'April') return 4;
    if (month == 'May') return 5;
    if (month == 'June') return 6;
    if (month == 'July') return 7;
    if (month == 'August') return 8;
    if (month == 'September') return 9;
    if (month == 'October') return 10;
    if (month == 'November') return 11;
   return 12;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<void>(
            stream: FirebaseFirestore.instance.collection('Running').orderBy('dateTime').snapshots(),
            builder: (BuildContext context, AsyncSnapshot runningsnapshot) {
              return Scaffold(
                body: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('Swimming').orderBy('dateTime').snapshots(),
                  builder:  (BuildContext context, swimmingsnapshot){
                    return Scaffold(
                    body: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('Bicycling').orderBy('dateTime').snapshots(),
                      builder: (BuildContext context, bikingsnapshot){
                        return Scaffold(

                body: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('Pilates').orderBy('dateTime').snapshots(),
                builder: (BuildContext context, pilatessnapshot) {

                var seriesList = createSampleData();
                var monthsRunning = List.filled(13, 0, growable: false);
                var monthsSwimming = List.filled(13, 0, growable: false);
                var monthsBiking = List.filled(13, 0, growable: false);
                var monthsPilates = List.filled(13, 0, growable: false);
                final orange = charts.MaterialPalette.deepOrange.makeShades(2);
                final blue = charts.MaterialPalette.indigo.makeShades(22);
                final red = charts.MaterialPalette.red.makeShades(60);
                final purple = charts.MaterialPalette.purple.makeShades(1);

                if (runningsnapshot.hasData && swimmingsnapshot.hasData) {

                for (int index = 0; index < runningsnapshot.data?.docs.length; index++) {
                DocumentSnapshot documentSnapshot = runningsnapshot.data?.docs[index];
                monthsRunning[returnMonth(documentSnapshot["dateTime"].toDate())] = monthsRunning[returnMonth(documentSnapshot["dateTime"].toDate())] + 1;
                }

                for (int index = 0; index < swimmingsnapshot.data!.docs.length; index++) {
                DocumentSnapshot documentSnapshot = swimmingsnapshot.data!.docs[index];
                monthsSwimming[returnMonth(documentSnapshot["dateTime"].toDate())] = monthsSwimming[returnMonth(documentSnapshot["dateTime"].toDate())] + 1;
                }

                for (int index = 0; index < bikingsnapshot.data!.docs.length; index++) {
                  DocumentSnapshot documentSnapshot = bikingsnapshot.data!.docs[index];
                  monthsBiking[returnMonth(documentSnapshot["dateTime"].toDate())] = monthsBiking[returnMonth(documentSnapshot["dateTime"].toDate())] + 1;
                }


                for (int index = 0; index < pilatessnapshot.data!.docs.length; index++) {
                  DocumentSnapshot documentSnapshot = pilatessnapshot.data!.docs[index];
                  monthsPilates[returnMonth(documentSnapshot["dateTime"].toDate())] = monthsPilates[returnMonth(documentSnapshot["dateTime"].toDate())] + 1;
                }

                final running_data = [
                new Workout('1', monthsRunning[1]),
                new Workout('2', monthsRunning[2]),
                new Workout('3', monthsRunning[3]),
                new Workout('4', monthsRunning[4]),
                new Workout('5', monthsRunning[5]),
                new Workout('6', monthsRunning[6]),
                new Workout('7', monthsRunning[7]),
                new Workout('8', monthsRunning[8]),
                new Workout('9', monthsRunning[9]),
                new Workout('10', monthsRunning[10]),
                new Workout('11', monthsRunning[11]),
                new Workout('12', monthsRunning[12]),
                ];

                final swimming_data = [
                new Workout('1', monthsSwimming[1]),
                new Workout('2', monthsSwimming[2]),
                new Workout('3', monthsSwimming[3]),
                new Workout('4', monthsSwimming[4]),
                new Workout('5', monthsSwimming[5]),
                new Workout('6', monthsSwimming[6]),
                new Workout('7', monthsSwimming[7]),
                new Workout('8', monthsSwimming[8]),
                new Workout('9', monthsSwimming[9]),
                new Workout('10', monthsSwimming[10]),
                new Workout('11', monthsSwimming[11]),
                new Workout('12', monthsSwimming[12]),
                ];

                final biking_data = [
                new Workout('1', monthsBiking[1]),
                new Workout('2', monthsBiking[2]),
                new Workout('3', monthsBiking[3]),
                new Workout('4', monthsBiking[4]),
                new Workout('5', monthsBiking[5]),
                new Workout('6', monthsBiking[6]),
                new Workout('7', monthsBiking[7]),
                new Workout('8', monthsBiking[8]),
                new Workout('9', monthsBiking[9]),
                new Workout('10', monthsBiking[10]),
                new Workout('11', monthsBiking[11]),
                new Workout('12', monthsBiking[12]),
                ];

                final pilates_data = [
                new Workout('1', monthsPilates[1]),
                new Workout('2', monthsPilates[2]),
                new Workout('3', monthsPilates[3]),
                new Workout('4', monthsPilates[4]),
                new Workout('5', monthsPilates[5]),
                new Workout('6', monthsPilates[6]),
                new Workout('7', monthsPilates[7]),
                new Workout('8', monthsPilates[8]),
                new Workout('9', monthsPilates[9]),
                new Workout('10', monthsPilates[10]),
                new Workout('11', monthsPilates[11]),
                new Workout('12', monthsPilates[12]),
                ];

                var running_series = new charts.Series<Workout, String>(
                id: 'Running',
                seriesCategory: 'running',
                domainFn: (Workout count, _) => count.month,
                measureFn: (Workout count, _) => count.count,
                data: running_data,
                colorFn: (Workout count, _) => red[1],
                );

                var swimming_series = new charts.Series<Workout, String>(
                id: 'Swimming',
                seriesCategory: 'swimming',
                domainFn: (Workout sales, _) => sales.month,
                measureFn: (Workout sales, _) => sales.count,
                data: swimming_data,
                colorFn: (Workout count, _) => orange[1],
                );

                var biking_series = new charts.Series<Workout, String>(
                id: 'Biking',
                seriesCategory: 'biking',
                domainFn: (Workout sales, _) => sales.month,
                measureFn: (Workout sales, _) => sales.count,
                data: biking_data,
                colorFn: (Workout count, _) => purple[1],
                );


                var pilates_series = new charts.Series<Workout, String>(
                id: 'Pilates',
                seriesCategory: 'pilates',
                domainFn: (Workout sales, _) => sales.month,
                measureFn: (Workout sales, _) => sales.count,
                data: pilates_data,
                colorFn: (Workout count, _) => blue[1],
                );


                seriesList = [];

                seriesList.add(running_series);
                seriesList.add(swimming_series);
                seriesList.add(biking_series);
                seriesList.add(pilates_series);

                }

                return new charts.BarChart(
                seriesList,
                animate: true,
                barGroupingType: charts.BarGroupingType.groupedStacked,
                behaviors: [
                new charts.ChartTitle('Workouts per month',
                behaviorPosition: charts.BehaviorPosition.top,
                titleOutsideJustification: charts.OutsideJustification
                    .middleDrawArea,
                innerPadding: 18),
                new charts.SeriesLegend(
                position: charts.BehaviorPosition.bottom,),
                ],
                );
                }));
                }
                    ),
                    );
                  }
                ),
              );
            }
        )
    );
  }
}


