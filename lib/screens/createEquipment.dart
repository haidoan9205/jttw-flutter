import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prm_se130184/color.dart';
import 'package:path/path.dart';
import 'package:prm_se130184/model/equipment.dart';
import 'package:prm_se130184/screens/equipment.dart';
import 'package:prm_se130184/screens/home.dart';
import 'package:prm_se130184/services/project_api.dart';
import 'dart:io';

class CreateEquipmentScreen extends StatefulWidget {
  Equipment equipment;
  CreateEquipmentScreen({Key key, this.equipment}) : super(key: key);
  @override
  _CreateEquipmentState createState() => _CreateEquipmentState();
}

class _CreateEquipmentState extends State<CreateEquipmentScreen> {
  bool _autoValidate = false;
  final _formKey = GlobalKey<FormState>();

  File _image;
  Equipment dto = new Equipment();
  TextEditingController name = new TextEditingController();
  TextEditingController description = new TextEditingController();
  TextEditingController image = new TextEditingController();
  TextEditingController quantity = new TextEditingController();

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      // print(_image);
    });
  }

  Future uploadImage(BuildContext context) async {
    String fileName = basename(_image.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    // FirebaseApp.initializeApp(this);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    if (taskSnapshot != null) {
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      image.text = downloadUrl;
      // return downloadUrl;
      // downloadUrl;
      // print(dowloadUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
        key: _formKey,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              "Create New Equipment",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: BackButton(),
            centerTitle: true,
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Container(
                            width: size.width * 0.5,
                            child: Image(
                              image: AssetImage("assets/images/equipment.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        OutlineButton(
                            child: Text("Pick Image"),
                            onPressed: () {
                              getImage();
                              uploadImage(context);
                            },
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)))
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                          color: primaryLightColor,
                          border: Border(
                              bottom: BorderSide(
                                  width: 1, color: Colors.grey[400]))),
                      child: TextFormField(
                        controller: name,
                        cursorColor: primaryColor,
                        decoration: InputDecoration(
                          hintText: "Equipment Name",
                          // errorText: _validate ? 'Name Can\'t Be Empty' : null,
                          border: InputBorder.none,
                        ),
                        validator: (value) =>
                            value.isEmpty ? 'Name cannot be blank' : null,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                          color: primaryLightColor,
                          border: Border(
                              bottom: BorderSide(
                                  width: 1, color: Colors.grey[400]))),
                      child: TextFormField(
                        controller: description,
                        cursorColor: primaryColor,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: "Description",
                          // errorText:
                          //     _validate ? 'Description Can\'t Be Empty' : null,
                          border: InputBorder.none,
                        ),
                        validator: (value) => value.isEmpty
                            ? 'Description cannot be blank'
                            : null,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                          color: primaryLightColor,
                          border: Border(
                              bottom: BorderSide(
                                  width: 1, color: Colors.grey[400]))),
                      child: TextFormField(
                        controller: quantity,
                        cursorColor: primaryColor,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Quantity",
                          // errorText:
                          // _validate : String validate,
                          border: InputBorder.none,
                        ),
                        validator: (value) =>
                            value.isEmpty ? 'Quantity cannot be blank' : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.only(right: 20, left: 20, bottom: 20, top: 10),
            width: MediaQuery.of(context).size.width,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              height: MediaQuery.of(context).size.width / 7,
              child: const Text(
                'Create',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  dto.equipmentName = name.text;
                  dto.description = description.text;
                  dto.image = image.text;
                  dto.quantity = int.parse(quantity.text);
                  // dto.email = email.text;
                  dto.isActive = true;
                  ProjectApi.createEquipment(dto);
                  Future.delayed(const Duration(milliseconds: 3500), () {
// Here you can write your code

                    Navigator.pop(
                      context,
                      MaterialPageRoute(builder: (context) => RootScreen()),
                    );
                  });
                }
              },
              color: primaryColor,
            ),
          ),
        ));
  }
}
