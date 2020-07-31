import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:prm_se130184/color.dart';
import 'package:prm_se130184/model/calamity.dart';
import 'package:prm_se130184/screens/calamity.dart';
import 'package:prm_se130184/screens/home.dart';
import 'package:prm_se130184/services/project_api.dart';
import 'package:intl/intl.dart';

class CreateCalamityScreen extends StatefulWidget {
  @override
  _CreateCalamityScreenState createState() => _CreateCalamityScreenState();
}

class _CreateCalamityScreenState extends State<CreateCalamityScreen> {
  bool _autoValidate = false;
  final _formKey = GlobalKey<FormState>();
  Calamity dto = new Calamity();

  TextEditingController name = new TextEditingController();
  TextEditingController description = new TextEditingController();
  TextEditingController location = new TextEditingController();
  TextEditingController startDate = new TextEditingController();
  TextEditingController endDate = new TextEditingController();
  TextEditingController filming = new TextEditingController();
  TextEditingController role = new TextEditingController();
  TextEditingController status = new TextEditingController();
  String _time = "Start time";
  String _time1 = "End time";
  DateTime dayStart;
  DateTime dayEnd;

  @override
  void initState() {
    dayStart = DateTime.now();
    dayEnd = DateTime.now();
    super.initState();
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
              "Create New Calamity",
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
                    SizedBox(height: size.height * 0.05),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Image.asset(
                        "assets/images/Calamity.PNG",
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
                        controller: name,
                        cursorColor: primaryColor,
                        decoration: InputDecoration(
                          hintText: "Calamity Name",
                          // errorText: _validate ? 'Name Can\'t Be Empty' : null,
                          border: InputBorder.none,
                        ),
                        validator: (value) => value.isEmpty
                            ? 'Calamity name cannot be blank'
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
                        controller: description,
                        cursorColor: primaryColor,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: "Description",
                          // errorText:
                          // _validate ? 'Description Can\'t Be Empty' : null,
                          border: InputBorder.none,
                        ),
                        validator: (value) => value.isEmpty
                            ? 'Calamity description cannot be blank'
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
                        controller: location,
                        cursorColor: primaryColor,
                        decoration: InputDecoration(
                          hintText: "Location",
                          // errorText: _validate ? 'Location Can\'t Be Empty' : null,
                          border: InputBorder.none,
                        ),
                        validator: (value) =>
                            value.isEmpty ? 'Location cannot be blank' : null,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                          color: primaryLightColor,
                          border: Border(
                              bottom: BorderSide(
                                  width: 1, color: Colors.grey[400]))),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        // elevation: 4.0,
                        onPressed: () {
                          DatePicker.showDateTimePicker(context,
                              theme: DatePickerTheme(
                                containerHeight: 210.0,
                              ),
                              showTitleActions: true, onConfirm: (date) {
                            print('confirm $date');
                            String formattedDate =
                                DateFormat('yyyy-MM-ddThh:mm:ss').format(date);

                            setState(() {
                              _time = formattedDate;
                              dayStart = date;
                            });
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en);
                          setState(() {});
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.access_time,
                                          size: 18.0,
                                          color: Colors.black,
                                        ),
                                        Text(
                                          " $_time",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 18.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: primaryLightColor,
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Colors.grey[400]))),
                        ),
                        color: primaryLightColor,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                          color: primaryLightColor,
                          border: Border(
                              bottom: BorderSide(
                                  width: 1, color: Colors.grey[400]))),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        // elevation: 4.0,
                        onPressed: () {
                          DatePicker.showDateTimePicker(context,
                              theme: DatePickerTheme(
                                containerHeight: 210.0,
                              ),
                              showTitleActions: true, onConfirm: (date) {
                            print('confirm $date');
                            String formattedDate =
                                DateFormat('yyyy-MM-ddThh:mm:ss').format(date);

                            setState(() {
                              _time1 = formattedDate;
                              dayEnd = date;
                            });
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en);
                          setState(() {});
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.access_time,
                                          size: 18.0,
                                          color: Colors.black,
                                        ),
                                        Text(
                                          " $_time1",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 18.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: primaryLightColor,
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Colors.grey[400]))),
                        ),
                        color: primaryLightColor,
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
                        controller: filming,
                        cursorColor: primaryColor,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Number of Filming",
                          // errorText: _validate ? 'Filmings Can\'t Be Empty' : null,
                          border: InputBorder.none,
                        ),
                        validator: (value) => value.isEmpty
                            ? 'Number of filming cannot be blank'
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
                        controller: role,
                        cursorColor: primaryColor,
                        decoration: InputDecoration(
                          hintText: "Role Specification",
                          // errorText: _validate ? 'Role Can\'t Be Empty' : null,
                          border: InputBorder.none,
                        ),
                        validator: (value) =>
                            value.isEmpty ? 'Role cannot be blank' : null,
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
                        controller: status,
                        cursorColor: primaryColor,
                        decoration: InputDecoration(
                          hintText: "Status",
                          // errorText: _validate,
                          border: InputBorder.none,
                        ),
                        validator: _validateStatus,
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
                  print(2);
                  dto.calamityName = name.text != null ? name.text : "";

                  dto.description =
                      description.text != null ? description.text : "";
                  dto.location = location.text != null ? location.text : "";
                  dto.startTime = _time.toString();
                  dto.endTime = _time1.toString();

                  print(3);
                  dto.numberOfFilming =
                      filming.text.isNotEmpty ? int.parse(filming.text) : 0;
                  print(3.5);
                  dto.roleSpecification = role.text != null ? role.text : "";
                  dto.status =
                      status.text.isNotEmpty ? int.parse(status.text) : 0;

                  print(4);
                  dto.isActive = true;
                  print(3);
                  ProjectApi.createCalamity(dto);
                  // print(4);
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

class DateTimePicker extends StatefulWidget {
  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

String _validateStatus(String value) {
  if (value.isEmpty) {
    // The form is empty
    return "Enter status";
  }
  // This is just a regular expression for email addresses
  String p = "[0-3]{1}";
  RegExp regExp = new RegExp(p);

  if (regExp.hasMatch(value)) {
    // So, the email is valid
    return null;
  }

  // The pattern of the email didn't match the regex above.
  return 'Status is not valid';
}

class _DateTimePickerState extends State<DateTimePicker> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CreateCalamityScreen(),
    );
  }
}
