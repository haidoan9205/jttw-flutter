import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prm_se130184/color.dart';
import 'package:prm_se130184/model/actor.dart';
import 'package:prm_se130184/screens/home.dart';
import 'package:prm_se130184/services/project_api.dart';

class CreateActorScreen extends StatefulWidget {
  Actor actor;
  CreateActorScreen({Key key, this.actor}) : super(key: key);
  @override
  _CreateActorState createState() => _CreateActorState();
}

class _CreateActorState extends State<CreateActorScreen> {
  bool _autoValidate = false;
  final _formKey = GlobalKey<FormState>();

  File _image;
  Actor dto = new Actor();
  TextEditingController name = new TextEditingController();
  TextEditingController description = new TextEditingController();
  TextEditingController image = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController phone = new TextEditingController();

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      // print(_image);
    });
    Future.delayed(const Duration(milliseconds: 3500), () {
// Here you can write your codec

      Navigator.pop(
        null,
        MaterialPageRoute(builder: (context) => CreateActorScreen()),
      );
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
        autovalidate: _autoValidate,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              "Create New Actor",
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
                              // image: AssetImage("assets/images/actor.PNG"),
                              image: image.text != null
                                  ? NetworkImage(image.text)
                                  : AssetImage("assets/images/actor.PNG"),
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
                    SizedBox(height: size.height * 0.05),
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
                          hintText: "Actor Name",
                          // errorText: _validate ? 'Name Can\'t Be Empty' : null,
                          border: InputBorder.none,
                        ),
                        validator: (value) =>
                            value.isEmpty ? 'Actor name cannot be blank' : null,
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
                            bottom:
                                BorderSide(width: 1, color: Colors.grey[400])),
                      ),
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
                            ? 'Actor description cannot be blank'
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
                        controller: email,
                        cursorColor: primaryColor,
                        decoration: InputDecoration(
                          hintText: "Email",
                          // errorText: _validate ? 'Email Can\'t Be Empty' : null,
                          border: InputBorder.none,
                        ),
                        validator: _validateEmail,
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
                            bottom:
                                BorderSide(width: 1, color: Colors.grey[400])),
                      ),
                      child: TextFormField(
                        controller: phone,
                        cursorColor: primaryColor,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Phone",
                          // errorText: _validate ? 'Phone Can\'t Be Empty' : null,
                          border: InputBorder.none,
                        ),
                        validator: _validatePhone,
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
                  // setState(() {
                  //   name.text.isEmpty &&
                  //           description.text.isEmpty &&
                  //           email.text.isEmpty &&
                  //           phone.text.isEmpty
                  //       ? _validate = true
                  //       : _validate = false;
                  // });
                  // dto.actorId = 5;
                  dto.actorName = name.text;
                  dto.description = description.text;
                  dto.image = image.text;
                  dto.phone = phone.text;
                  dto.email = email.text;
                  dto.isActive = true;
                  ProjectApi.createActor(dto);
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

  String _validateEmail(String value) {
    if (value.isEmpty) {
      // The form is empty
      return "Enter email address";
    }
    // This is just a regular expression for email addresses
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);

    if (regExp.hasMatch(value)) {
      // So, the email is valid
      return null;
    }

    // The pattern of the email didn't match the regex above.
    return 'Email is not valid';
  }

  String _validatePhone(String value) {
    if (value.isEmpty) {
      // The form is empty
      return "Enter phone number";
    }
    // This is just a regular expression for email addresses
    String p = "[0-9]{10}";
    RegExp regExp = new RegExp(p);

    if (regExp.hasMatch(value)) {
      // So, the email is valid
      return null;
    }

    // The pattern of the email didn't match the regex above.
    return 'Phone number is not valid';
  }
}
