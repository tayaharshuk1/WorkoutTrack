import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import 'widgets/widgetToImage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:workout_tracker/scatterChartRunning.dart';
import 'package:workout_tracker/scatterChartSwimming.dart';
//import 'package:path_provider/path_provider.dart';
import 'Utils.dart';
import 'pdf_api.dart';
import 'myPieChart.dart';
import 'widgetToImage.dart';
import 'variables.dart' as globals;
import 'barChart.dart';
import 'scatterChartRunning.dart';
import 'scatterChartSwimming.dart';
import 'scatterChartBiking.dart';
import 'scatterChartPilates.dart';


String parse (String s){
  String returned="";
  String date = s;
  String year = date.substring(0,4);
  String month = date.substring(5,7);
  String day = date.substring(8,10);
  String hour = date.substring(11,16);

  returned =  day + "/" + month + "/" +year  + " , " + hour;
  return returned;
}



class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  late GlobalKey key1 = GlobalKey();
  Uint8List bytes1 = Uint8List(2);
  late GlobalKey key2 = GlobalKey();
  Uint8List bytes2 = Uint8List(2);
  late GlobalKey key3 = GlobalKey();
  Uint8List bytes3 = Uint8List(2);
  late GlobalKey key4 = GlobalKey();
  Uint8List bytes4 = Uint8List(2);
  late GlobalKey key5 = GlobalKey();
  Uint8List bytes5 = Uint8List(2);
  late GlobalKey key6 = GlobalKey();
  Uint8List bytes6 = Uint8List(2);
  late GlobalKey key7 = GlobalKey();
  Uint8List bytes7 = Uint8List(2);
  late GlobalKey key8 = GlobalKey();
  Uint8List bytes8 = Uint8List(2);
  late GlobalKey key9 = GlobalKey();
  Uint8List bytes9 = Uint8List(2);

  //Uint8List bytes_ = 0 as Uint8List;

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(2022, 11, 5),
    end: DateTime(2022, 12, 24),
  );


  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (newDateRange == null) return; // pressed 'X'

    setState(() => dateRange = newDateRange); // pressed 'SAVE'
  }

  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;
    return Scaffold(
      body: Center(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Profile').snapshots(),
            builder: (context, profilesnap) {
              return Scaffold(
                body: Center(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('Running')
                          .snapshots(),
                      builder: (context, runningsnapshot) {
                        return Scaffold(
                          body: Center(
                            child: StreamBuilder(
                                stream: FirebaseFirestore.instance.collection(
                                    'Swimming').snapshots(),
                                builder: (context, swimmingsnapshot) {
                                  return DefaultTabController(
                                    length: 4,
                                    child: Scaffold(
                                      floatingActionButton: FloatingActionButton(
                                        tooltip: 'Send report',
                                        onPressed: () async {
                                          String Name = profilesnap.data
                                              ?.docs[0]['Name'] ?? '';
                                          String birthday = profilesnap.data
                                              ?.docs[0]['Date of Birth'] ?? '';
                                          String IDnumber = profilesnap.data
                                              ?.docs[0]['ID number'] ?? '';


                                          final bytes_1 = await Utils.capture(
                                              key1);
                                          final bytes_2 = await Utils.capture(
                                              key2);
                                          final bytes_3 = await Utils.capture(
                                              key3);
                                          final bytes_4 = await Utils.capture(
                                              key4);
                                          final bytes_5 = await Utils.capture(
                                              key5);
                                          setState(() {
                                            bytes1 = bytes_1;
                                            bytes2 = bytes_2;
                                            bytes3 = bytes_3;
                                            bytes4 = bytes_4;
                                            bytes5 = bytes_5;
                                          });

                                          PdfApi.createPDF(
                                              Name,
                                              birthday,
                                              IDnumber,
                                              bytes1,
                                              bytes2,
                                              bytes3,
                                              bytes4,
                                              bytes5,
                                              );
                                        },
                                        backgroundColor: Colors.blue,
                                        child: const Icon(Icons.send),
                                      ),
                                      appBar: AppBar(
                                        title: const Text('Workout Statistics'),
                                      ),
                                      body: TabBarView(
                                        children: [
                                          CustomScrollView(
                                            slivers: <Widget>[
                                              SliverList(
                                                delegate: SliverChildBuilderDelegate(
                                                      (BuildContext context,
                                                      int index) {
                                                    Size size = MediaQuery
                                                        .of(context)
                                                        .size;
                                                    return Container(
                                                      height: 2100 - MediaQuery
                                                          .of(context)
                                                          .viewInsets
                                                          .bottom,
                                                      color: Colors.black12,
                                                      child: SingleChildScrollView(
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 7.0,
                                                              width: size.width,
                                                            ),


                                                            // space

                                                            SizedBox(
                                                              height: 250.0,
                                                              width: size.width,
                                                              child: WidgetToImage(
                                                                builder: (key) {
                                                                  key1 = key;
                                                                  globals.key_1 =
                                                                      key;
                                                                  return Card(
                                                                    elevation: 3.5,
                                                                    child: pieChartDB(),
                                                                    shape: RoundedRectangleBorder(
                                                                      side: BorderSide(
                                                                        color: Theme
                                                                            .of(
                                                                            context)
                                                                            .colorScheme
                                                                            .outline,
                                                                      ),
                                                                      borderRadius: const BorderRadius
                                                                          .all(
                                                                          Radius
                                                                              .circular(
                                                                              12)),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ),

                                                            SizedBox(
                                                              height: 8,
                                                              width: size.width,
                                                            ),

                                                            SizedBox(
                                                              height: 370.0,
                                                              width: size.width,
                                                              child: WidgetToImage(
                                                                  builder: (key) {
                                                                    key2 = key;
                                                                    return Card(
                                                                      elevation: 3.5,
                                                                      shape: RoundedRectangleBorder(
                                                                        side: BorderSide(
                                                                          color: Theme
                                                                              .of(
                                                                              context)
                                                                              .colorScheme
                                                                              .outline,
                                                                        ),
                                                                        borderRadius: const BorderRadius
                                                                            .all(
                                                                            Radius
                                                                                .circular(
                                                                                20)),
                                                                      ),
                                                                      child: BarChart(),
                                                                    );
                                                                  }),
                                                            ),


                                                            SizedBox(
                                                              height: 10,
                                                              width: size.width,
                                                            ),

                                                            SizedBox(
                                                              height: 250.0,
                                                              width: size.width,
                                                              child: WidgetToImage(
                                                                  builder: (key) {
                                                                    key3 = key;
                                                                    return Card(
                                                                      elevation: 3.5,
                                                                      child: scatterChartRunning(),
                                                                      shape: RoundedRectangleBorder(
                                                                        side: BorderSide(
                                                                          color: Theme
                                                                              .of(
                                                                              context)
                                                                              .colorScheme
                                                                              .outline,
                                                                        ),
                                                                        borderRadius: const BorderRadius
                                                                            .all(
                                                                            Radius
                                                                                .circular(
                                                                                12)),
                                                                      ),
                                                                    );
                                                                  }),
                                                            ),

                                                            SizedBox(
                                                              height: 10,
                                                              width: size.width,
                                                            ),

                                                            SizedBox(
                                                              height: 250.0,
                                                              width: size.width,
                                                              child: WidgetToImage(
                                                                  builder: (key) {
                                                                    key4 = key;
                                                                    return Card(
                                                                      elevation: 3.5,
                                                                      child: scatterChartSwimming(),
                                                                      shape: RoundedRectangleBorder(
                                                                        side: BorderSide(
                                                                          color: Theme
                                                                              .of(
                                                                              context)
                                                                              .colorScheme
                                                                              .outline,
                                                                        ),
                                                                        borderRadius: const BorderRadius
                                                                            .all(
                                                                            Radius
                                                                                .circular(
                                                                                12)),
                                                                      ),
                                                                    );
                                                                  }),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                              width: size.width,
                                                            ),

                                                            SizedBox(
                                                              height: 250.0,
                                                              width: size.width,
                                                              child: WidgetToImage(
                                                                  builder: (key) {
                                                                    key5 = key;
                                                                    return Card(
                                                                      elevation: 3.5,
                                                                      child: scatterChartBiking(),
                                                                      shape: RoundedRectangleBorder(
                                                                        side: BorderSide(
                                                                          color: Theme
                                                                              .of(
                                                                              context)
                                                                              .colorScheme
                                                                              .outline,
                                                                        ),
                                                                        borderRadius: const BorderRadius
                                                                            .all(
                                                                            Radius
                                                                                .circular(
                                                                                12)),
                                                                      ),
                                                                    );
                                                                  }),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                              width: size.width,
                                                            ),

                                                          /*  SizedBox(
                                                              height: 250.0,
                                                              width: size.width,
                                                              child: WidgetToImage(
                                                                  builder: (key) {
                                                                    key5 = key;
                                                                    return Card(
                                                                      elevation: 3.5,
                                                                      child: scatterChartPilates(),
                                                                      shape: RoundedRectangleBorder(
                                                                        side: BorderSide(
                                                                          color: Theme
                                                                              .of(
                                                                              context)
                                                                              .colorScheme
                                                                              .outline,
                                                                        ),
                                                                        borderRadius: const BorderRadius
                                                                            .all(
                                                                            Radius
                                                                                .circular(
                                                                                12)),
                                                                      ),
                                                                    );
                                                                  }),
                                                            ),*/
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  childCount: 1,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                            ),
                          ),
                        );
                      }
                  ),
                ),
              );
            }
        ),
      ),
    );

  }

  Widget buildImage(Uint8List bytes) =>
      bytes != null ? Image.memory(bytes) : Container();
}
