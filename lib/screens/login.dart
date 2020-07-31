import 'package:flutter/material.dart';
import 'package:prm_se130184/color.dart';
import 'package:prm_se130184/model/user.dart';
import 'package:prm_se130184/screens/equipment.dart';
import 'package:prm_se130184/screens/home.dart';
import 'package:prm_se130184/services/project_api.dart';

class LoginScreen extends StatelessWidget {
  bool _autoValidate = false;
  final _formKey = GlobalKey<FormState>();

  User dto = new User();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
        key: _formKey,
        child: Scaffold(
          backgroundColor: Colors.lightBlue[50],
          appBar: AppBar(
            title: Text(
              "Journey To The West",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: primaryLightColor),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: size.height * 0.1),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        'https://scontent.fsgn2-1.fna.fbcdn.net/v/t1.0-9/86381857_1512578865572451_7035154579717095424_n.jpg?_nc_cat=107&_nc_sid=09cbfe&_nc_ohc=TZoVDP8K-PoAX-9cDcS&_nc_ht=scontent.fsgn2-1.fna&oh=5ca84b97d6b461eeb5b6c81c6aa766d9&oe=5F37169B'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                        color: primaryLightColor,
                        // borderRadius: BorderRadius.zero,
                        border: Border(
                            bottom:
                                BorderSide(width: 1, color: Colors.grey[400]))),
                    child: TextFormField(
                      controller: name,
                      cursorColor: primaryColor,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: primaryColor,
                        ),
                        hintText: "Username",
                        border: InputBorder.none,
                      ),
                      validator: (value) =>
                          value.isEmpty ? 'Username cannot be blank' : null,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                      color: primaryLightColor,
                      // borderRadius: BorderRadius.zero,
                      border: Border(
                          bottom:
                              BorderSide(width: 1, color: Colors.grey[400]))),
                  child: TextFormField(
                    obscureText: true,
                    controller: password,
                    cursorColor: primaryColor,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.lock,
                        color: primaryColor,
                      ),
                      hintText: "Password",
                      border: InputBorder.none,
                    ),
                    validator: (value) =>
                        value.isEmpty ? 'Password cannot be blank' : null,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: size.width * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(29),
                    child: FlatButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                      color: primaryColor,
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            color: primaryLightColor,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          dto.userId = name.text;
                          dto.password = password.text;
                          ProjectApi.login(dto);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RootScreen()),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
