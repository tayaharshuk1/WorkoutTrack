import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'setProfilePage.dart';
import 'setWorkouts.dart';
import 'setGraphsPage.dart';
import 'authentication/mainPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }

}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {

  void _pushProfile() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return  ProfilePage();
    }));
  }

  void _pushWorkouts() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return  setWorkouts();
    }));
  }
  void _pushGraphs() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return  StatisticsPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: OverflowBar(
              alignment: MainAxisAlignment.spaceEvenly,
              overflowAlignment: OverflowBarAlignment.center,
              children: <Widget>[


                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.stacked_bar_chart_outlined, color: Colors.redAccent,),
                      onPressed: () {_pushGraphs();},
                      tooltip: "Graphs",
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.person_outlined, color: Colors.redAccent,),
                      onPressed: () {_pushProfile();},
                      tooltip: "Profile",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: setWorkouts()
    );
  }
}
