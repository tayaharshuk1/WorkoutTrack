//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
//import '../../icons/custom_icons_icons.dart';
import 'authentication/loginPage.dart';
import 'text_dialog.dart';
//import 'package:image_picker/image_picker.dart';
import 'dart:io';
//import '../authentication/login/login_page.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
//import 'package:path/path.dart';
import 'package:path/path.dart' as path;




class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? image;
  String? imgURL = "https://www.freepik.com/free-photo/horizontal-shot-satisfied-motivated-sportswoman-has-regular-training-raises-arms-with-dumbbells-does-exercises-muscles-dressed-sportswear-smiles-toothily-isolated-pink-wall-sport-concept_23178612.htm?query=workout&collectionId=1151&&position=0&from_view=collections";


  Future _getImage() async {
     var img = await ImagePicker().pickImage(source: ImageSource.gallery);
     setState((){
       image = img as File;
     });
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        _photo = File(pickedFile.path);
      });
    }
  }

  void _pushLogin() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return LoginPage();
    }));
  }

  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage
      .instance;

  File? _photo;

  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = path.basename(_photo!.path);
    final destination = 'files/profileImage';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      await ref.putFile(_photo!);
    } catch (e) {
      print('error occured');
    }
  }

  downloadURL() async {
    var imageURL = "https://img.freepik.com/free-photo/portrait-smiling-little-kid-standing_171337-7107.jpg?w=900&t=st=1674519886~exp=1674520486~hmac=dd5daadce50841abb6e606bd21a96036f6332ed4e5f8b77e226743ecb21d9ec7";
    try {
      final ref = firebase_storage.FirebaseStorage.instance.ref(
          'files/profileImage').child('files/profileImage');
      imageURL = await ref.getDownloadURL();
      setState(() {
        imageURL:
        imageURL.toString();
      });
    } catch (e) {
      print('error occured');
      setState(() {
        imageURL:
        imageURL.toString();
      });
    }
  }


  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                       // imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                    //  imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    IconData create = IconData(0xe19d, fontFamily: 'MaterialIcons');
   firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage
        .instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Center(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Profile')
                .snapshots(),
            builder: (context, snapshot) {
              return DefaultTabController(
                length: 3,
                child: Scaffold(
                  body: TabBarView(
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                              children: [
                                SizedBox(
                                  height: 250,
                                  width: 200,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    fit: StackFit.expand,
                                    children: [
                                      SizedBox(height: 50, width: 39,),
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        child: InkWell(
                                          onTap: () async {
                                            PickedFile? pickedFile = await ImagePicker()
                                                .getImage(
                                              source: ImageSource.gallery,
                                              maxWidth: 1800,
                                              maxHeight: 1800,
                                            );
                                            if (pickedFile != null) {
                                              setState(() {
                                                _photo = File(pickedFile.path);
                                              });
                                            }
                                          },
                                          child:

                                          CircleAvatar(
                                            radius: 100,
                                            backgroundImage: AssetImage('images/412.jpg'),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        left: -15,
                                        child: RawMaterialButton(
                                          onPressed: () async {
                                            // PickedFile? pickedFile = await ImagePicker().getImage(
                                            //   source: ImageSource.gallery,
                                            //   maxWidth: 1800,
                                            //   maxHeight: 1800,
                                            // );
                                            // if (pickedFile != null) {
                                            //   setState(() {
                                            //     image = File(pickedFile.path);
                                            //   });
                                            // }
                                            _showPicker(context);
                                          },
                                          elevation: 5.0,
                                          fillColor: Color(0xFFF5F6F9),
                                          child: Icon(Icons.camera_alt_outlined,
                                            color: Colors.blue,),
                                          padding: EdgeInsets.all(15.0),
                                          shape: CircleBorder(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 12),
            //logout
                                SizedBox(height: 12),
                                Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                        children: [
                                          Card(
                                            child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text('Name',
                                                        style: TextStyle( fontWeight: FontWeight.bold,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                0.6)),),
                                                      Text("  "+snapshot.data
                                                          ?.docs[0]['Name'] ??
                                                          ''),
                                                    ],
                                                  ),
                                                  IconButton(
                                                    icon: Icon(create),
                                                    color: Colors.blue,
                                                    onPressed: () {
                                                      editName();
                                                    },
                                                  ),
                                                ]
                                            ),
                                          ), //name
                                          SizedBox(height: 10),
                                          Card(
                                            child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Text("  Date of Birth",
                                                        style: TextStyle(fontWeight: FontWeight.bold,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                0.6)),),
                                                      Text("  "+ snapshot.data
                                                          ?.docs[0]['Date of Birth'] ??
                                                          '')
                                                    ],
                                                  ),
                                                  IconButton(
                                                    icon: Icon(create),
                                                    color: Colors.blue,
                                                    onPressed: () {
                                                      editDateOfBirth();
                                                    },
                                                  ),
                                                ]
                                            ) ,
                                          ),
                                          //age
                                          SizedBox(height: 10),
                                          Card(
                                            child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Text("  ID number",
                                                        style: TextStyle(fontWeight: FontWeight.bold,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                0.6)),),
                                                      Text("  "+snapshot.data
                                                          ?.docs[0]['ID number'] ??
                                                          ''),
                                                    ],
                                                  ),
                                                  IconButton(
                                                    icon: Icon(create),
                                                    color: Colors.blue,
                                                    onPressed: () {
                                                      editIDNumber();
                                                    },
                                                  ),
                                                ]
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Card(child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text("  Email",
                                                      style: TextStyle(fontWeight: FontWeight.bold,
                                                          color: Colors.black
                                                              .withOpacity(
                                                              0.6)),),
                                                    Text("  "+snapshot.data
                                                        ?.docs[0]['Email'] ??
                                                        '')
                                                  ],
                                                ),
                                                IconButton(
                                                  icon: Icon(create),
                                                  color: Colors.blue,
                                                  onPressed: () {
                                                    editEmail();
                                                  },
                                                ),
                                              ]
                                          ),),
                                          SizedBox(height: 15),
                                          TextButton(
                                            style: ButtonStyle(
                                              minimumSize: MaterialStateProperty.all(
                                                  Size(240, 60)),
                                              foregroundColor: const MaterialStatePropertyAll<
                                                  Color>(Colors.white),
                                              backgroundColor: const MaterialStatePropertyAll<
                                                  Color>(Colors.lightBlueAccent),
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(
                                                      30.0),
                                                  side: const BorderSide(width: 3,
                                                      color: Colors.lightBlueAccent),
                                                ),
                                              ),
                                            ),
                                            onPressed: () async{
                                              setState(() async {
                                                await FirebaseAuth.instance.signOut();
                                                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginPage()));
                                                _pushLogin();
                                              });
                                            },
                                            child: Column(
                                              children: const <Widget>[
                                                Text("Log out"),
                                              ],
                                            ),
                                          ),
                                           //i
                                        ]
                                    )
                                ),
                              ]
                          ),
                        ),
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

  Future editName() async {
    final name = await showTextDialog(
      context,
      title: 'Change Name',
      value: '',
      doc: 'Profile',
      field: 'Name',
    );
  }

  Future editDateOfBirth() async {
    final name = await showTextDialog(
      context,
      title: 'Change Date of Birth',
      value: '',
      doc: 'Profile',
      field: 'Date of Birth',
    );
  }

  Future editIDNumber() async {
    final name = await showTextDialog(
      context,
      title: 'Change ID number',
      value: '',
      doc: 'Profile',
      field: 'ID number',
    );
  }

  Future editEmail() async {
    final name = await showTextDialog(
      context,
      title: 'Change Email address',
      value: '',
      doc: 'Profile',
      field: 'Email',
    );
  }

  Future editMedicineName_routine() async {
    final name = await showTextDialog(
      context,
      title: 'Change Medicine Name',
      value: '',
      doc: 'Medications',
      field: 'medicine name',
    );
  }

  Future editMedicineName_acute() async {
    final name = await showTextDialog(
      context,
      title: 'Change Medicine Name',
      value: '',
      doc: 'Medications_acute',
      field: 'Medicine name',
    );
  }

  Future editPrescriptedDose_routine() async {
    final name = await showTextDialog(
      context,
      title: 'Change Prescription',
      value: '',
      doc: 'Medications',
      field: 'Prescripted Dose',
    );
  }

  Future editPrescriptedDose_acute() async {
    final name = await showTextDialog(
      context,
      title: 'Change Prescription',
      value: '',
      doc: 'Medications_acute',
      field: 'Prescripted Dose',
    );
  }

  Future editNumOfDoses_routine() async {
    final name = await showTextDialog(
      context,
      title: 'Change number of doses in bottle',
      value: '',
      doc: 'Medications',
      field: 'Num of doses in bottle',
    );
  }

  Future editNumOfDoses_acute() async {
    final name = await showTextDialog(
      context,
      title: 'Change number of doses in bottle',
      value: '',
      doc: 'Medications_acute',
      field: 'Num of doses in bottle',
    );
  }

  Future editExpirationDate_routine() async {
    final name = await showTextDialog(
      context,
      title: 'Change Expiration Date',
      value: '',
      doc: 'Medications',
      field: 'Expiration Date',
    );
  }

  Future editExpirationDate_acute() async {
    final name = await showTextDialog(
      context,
      title: 'Change Expiration Date',
      value: '',
      doc: 'Medications_acute',
      field: 'Expiration Date',
    );
  }

  Future editDoctorName() async {
    final name = await showTextDialog(
      context,
      title: "Change Doctor's name",
      value: '',
      doc: 'Doctor',
      field: 'Doctor name',
    );
  }

  Future editDoctorEmail() async {
    final name = await showTextDialog(
      context,
      title: "Change Doctor's email",
      value: '',
      doc: 'Doctor',
      field: 'Doctor email',
    );
  }

}
