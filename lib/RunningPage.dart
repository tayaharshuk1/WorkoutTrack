import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class RunningPage extends StatefulWidget {
  const RunningPage({Key? key}) : super(key: key);

  @override
  State<RunningPage> createState() => _RunningPageState();
}

class _RunningPageState extends State<RunningPage> {
  DateTime dateTime = DateTime.now();
  String dateTimeMin = DateTime.now().minute.toString();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height*.45,
            decoration: BoxDecoration(color: Colors.red[100],
              //image: DecorationImage(image: AssetImage("lib/sport.jpg")),
            ),
          ),
          SafeArea(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 100,),
                Text("Add a new running workout!" , style: TextStyle(fontSize: 40,
                    fontWeight: FontWeight.bold, color: Colors.black54),),
                SizedBox(height: 90,),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Container(
                          width: 1000,
                          decoration: const BoxDecoration(
                              boxShadow: [BoxShadow(color: Colors.black26, spreadRadius: 3, blurRadius: 10, offset: Offset(15,5))],
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              //color: Colors.blue,
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [Colors.blue, Colors.red,],
                              )
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async{
                          DateTime? newDate = await showDatePicker(
                            context: context, initialDate: dateTime, firstDate: DateTime(2000), lastDate: DateTime(2100),);
                          if (newDate == null){
                            return;
                          }
                          TimeOfDay? newTime = await showTimePicker(context: context, initialTime: TimeOfDay(hour: dateTime.hour+2, minute: dateTime.minute));
                          if (newTime == null){
                            return;
                          }
                          final updatedDateTime = DateTime(newDate.year,newDate.month,newDate.day,newTime.hour, newTime.minute,);
                          setState(() {
                            dateTime = updatedDateTime;
                            if(updatedDateTime.minute < 10){
                              dateTimeMin = '0'+ updatedDateTime.minute.toString();
                            }
                            else{
                              dateTimeMin = updatedDateTime.minute.toString();
                            }
                          }
                          );
                        },
                        child: Row(
                          children: [
                            SizedBox(width: 15,),
                            Icon( Icons.calendar_today, color: Colors.white,size: 30,),
                            SizedBox(width: 25,),
                            Container(
                              height: 50, margin: EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Text('${dateTime.day}/${dateTime.month}/${dateTime.year} - ${dateTime.hour+2}:${dateTimeMin}', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          )),
        ],
      ),
    );
  }
}
