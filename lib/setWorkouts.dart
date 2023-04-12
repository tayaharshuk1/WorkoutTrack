
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class setWorkouts extends StatefulWidget {
  const setWorkouts({Key? key}) : super(key: key);

  @override
  State<setWorkouts> createState() => _setWorkoutsState();
}

class _setWorkoutsState extends State<setWorkouts> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height*.45,
            decoration:  BoxDecoration( gradient: LinearGradient(
                end: Alignment.topLeft,
                begin: Alignment.bottomRight,
                colors: [
                  Color(0xFFFFEBEE),
                  Color(0xFFEF9A9A),
                  Color(0xFFEF5350),
                ]
            ))
          ),
          SafeArea(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 30,),
                Text("Have you worked out today?" , style: GoogleFonts.bebasNeue(
                    fontSize: 55, color: Colors.black54)),
                SizedBox(height: 70,),
                Expanded(
                  child: GridView.count(crossAxisCount: 2, childAspectRatio: .85,mainAxisSpacing: 30,crossAxisSpacing: 20,
                  children: [
                    WorkoutCard(photo: "images/womenrunning.png", title: 'Running',),
                    WorkoutCard(photo: "images/swimming-svgrepo-com.png", title: 'Swimming',),
                    WorkoutCard(photo: "images/bicycle.png", title: 'Biking',),
                    WorkoutCard(photo: "images/yoga.png", title: 'Pilates',),

                  ],),
                )
              ],
            ),
          )),
        ],
      ),
    );
  }
}




class WorkoutCard extends StatefulWidget {
  final String photo;
  final String title;
  const WorkoutCard({Key? key, required this.photo, required this.title}) : super(key: key);


  @override
  State<WorkoutCard> createState() => _WorkoutCardState();
}

class _WorkoutCardState extends State<WorkoutCard> {

  DateTime dateTime = DateTime.now();
  String dateTimeMin = DateTime.now().minute.toString();
  final CollectionReference _running = FirebaseFirestore.instance.collection('Running');
  final CollectionReference _swimming = FirebaseFirestore.instance.collection('Swimming');
  final CollectionReference _bicycling = FirebaseFirestore.instance.collection('Bicycling');
  final CollectionReference _pilates = FirebaseFirestore.instance.collection('Pilates');
  final TextEditingController _runningDistanceController = TextEditingController();
  final TextEditingController _runningTimeController = TextEditingController();
  final TextEditingController _swimmingDistanceController = TextEditingController();
  final TextEditingController _swimmingTimeController = TextEditingController();
  final TextEditingController _bicyclingDistanceController = TextEditingController();
  final TextEditingController _bicyclingTimeController = TextEditingController();
  final TextEditingController _pilatesTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
          color: Colors.white, boxShadow: [BoxShadow(offset: Offset(0,10), blurRadius: 13,spreadRadius: -15)]),
      child: Material(
        child: InkWell(

          onTap: () async {
            if (widget.title == 'Running'){
              await showModalBottomSheet(useRootNavigator: true, context: context, clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24),),),
                builder: (BuildContext ctx) {
                  return Container(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        Text("Add a new running workout!" , style: TextStyle(fontSize: 20,
                            fontWeight: FontWeight.bold, color: Colors.black54),),
                        SizedBox(height: 20,),
                        Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                child: Container(
                                  width: 1200,
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
                                    SizedBox(width: 20,),
                                    Expanded(
                                      child: Container(
                                        height: 60, width: 70, margin: EdgeInsets.all(5),
                                        child: Flexible(
                                          child: Row(
                                            children: [
                                              Flexible(child: Text('${dateTime.day}/${dateTime.month}/${dateTime.year} - ${dateTime.hour+2}:${dateTimeMin}'+'  ', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),)),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                        SizedBox(height: 30,),
                        TextField(
                          controller: _runningDistanceController,
                          decoration: const InputDecoration(labelText: 'Distance'),
                        ),
                        SizedBox(height: 30,),
                        TextField(
                          controller: _runningTimeController,
                          decoration: const InputDecoration(labelText: 'Time'),
                        ),
                        SizedBox(height: 20,),
                        FloatingActionButton.extended(
                          onPressed: () async {
                            await _running.add({"Distance": _runningDistanceController.text, "Time": _runningTimeController.text, "dateTime": dateTime});
                            // _titleController.text = '';
                            Navigator.of(context).pop();
                          },
                          //icon: Icon(Icons.alarm),
                          backgroundColor: Colors.indigo[300],
                          label: Text('Save'),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            if (widget.title == 'Swimming'){
              await showModalBottomSheet(useRootNavigator: true, context: context, clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24),),),
                builder: (BuildContext ctx) {
                  return Container(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        Text("Add a new swimming workout!" , style: TextStyle(fontSize: 20,
                            fontWeight: FontWeight.bold, color: Colors.black54),),
                        SizedBox(height: 20,),
                        Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                child: Container(
                                  width: 1200,
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
                                    SizedBox(width: 20,),
                                    Expanded(
                                      child: Container(
                                        height: 60, width: 70, margin: EdgeInsets.all(5),
                                        child: Flexible(
                                          child: Row(
                                            children: [
                                              Flexible(child: Text('${dateTime.day}/${dateTime.month}/${dateTime.year} - ${dateTime.hour+2}:${dateTimeMin}'+'  ', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),)),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                        SizedBox(height: 30,),
                        TextField(
                          controller: _swimmingDistanceController,
                          decoration: const InputDecoration(labelText: 'Distance'),
                        ),
                        SizedBox(height: 30,),
                        TextField(
                          controller: _swimmingTimeController,
                          decoration: const InputDecoration(labelText: 'Time'),
                        ),
                        SizedBox(height: 20,),
                        FloatingActionButton.extended(
                          onPressed: () async {
                            await _swimming.add({"Distance": _swimmingDistanceController.text, "Time": _swimmingTimeController.text,"dateTime": dateTime});
                            // _titleController.text = '';
                            Navigator.of(context).pop();
                          },
                          //icon: Icon(Icons.alarm),
                          backgroundColor: Colors.indigo[300],
                          label: Text('Save'),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            if (widget.title == 'Biking'){
              await showModalBottomSheet(useRootNavigator: true, context: context, clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24),),),
                builder: (BuildContext ctx) {
                  return Container(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        Text("Add a new biking workout!" , style: TextStyle(fontSize: 20,
                            fontWeight: FontWeight.bold, color: Colors.black54),),
                        SizedBox(height: 20,),
                        Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                child: Container(
                                  width: 1200,
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
                                    SizedBox(width: 20,),
                                    Expanded(
                                      child: Container(
                                        height: 60, width: 70, margin: EdgeInsets.all(5),
                                        child: Flexible(
                                          child: Row(
                                            children: [
                                              Flexible(child: Text('${dateTime.day}/${dateTime.month}/${dateTime.year} - ${dateTime.hour+2}:${dateTimeMin}'+'  ', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),)),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                        SizedBox(height: 30,),
                        TextField(
                          controller: _bicyclingDistanceController,
                          decoration: const InputDecoration(labelText: 'Distance'),
                        ),
                        SizedBox(height: 30,),
                        TextField(
                          controller: _bicyclingTimeController,
                          decoration: const InputDecoration(labelText: 'Time'),
                        ),
                        SizedBox(height: 20,),
                        FloatingActionButton.extended(
                          onPressed: () async {
                            await _bicycling.add({"Distance": _bicyclingDistanceController.text, "Time": _bicyclingTimeController.text,"dateTime": dateTime});
                            // _titleController.text = '';
                            Navigator.of(context).pop();
                          },
                          //icon: Icon(Icons.alarm),
                          backgroundColor: Colors.indigo[300],
                          label: Text('Save'),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            if (widget.title == 'Pilates'){
              await showModalBottomSheet(useRootNavigator: true, context: context, clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24),),),
                builder: (BuildContext ctx) {
                  return Container(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        Text("Add a new pilates workout!" , style: TextStyle(fontSize: 20,
                            fontWeight: FontWeight.bold, color: Colors.black54),),
                        SizedBox(height: 20,),
                        Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                child: Container(
                                  width: 1200,
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
                                    SizedBox(width: 20,),
                                    Expanded(
                                      child: Container(
                                        height: 60, width: 70, margin: EdgeInsets.all(5),
                                        child: Flexible(
                                          child: Row(
                                            children: [
                                              Flexible(child: Text('${dateTime.day}/${dateTime.month}/${dateTime.year} - ${dateTime.hour+2}:${dateTimeMin}'+'  ', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),)),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),

                        SizedBox(height: 30,),
                        TextField(
                          controller: _pilatesTimeController,
                          decoration: const InputDecoration(labelText: 'Time'),
                        ),
                        SizedBox(height: 20,),
                        FloatingActionButton.extended(
                          onPressed: () async {
                            await _pilates.add({ "Time": _pilatesTimeController.text,"dateTime": dateTime});
                            // _titleController.text = '';
                            Navigator.of(context).pop();
                          },
                          //icon: Icon(Icons.alarm),
                          backgroundColor: Colors.indigo[300],
                          label: Text('Save'),
                        ),
                      ],
                    ),
                  );
                },
              );
            }

          },
          child: Column(
            children: [
              //SvgPicture.asset("lib/images/running.svg"),
              SizedBox(height: 50),
              Image.asset(widget.photo,width: 200,height: 100,),
              Spacer(),
              Text(widget.title, style: TextStyle(color: Colors.black54,fontSize: 18, fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ),
    );
  }
}
