import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prm_se130184/model/calamity.dart';
import 'package:prm_se130184/screens/calamity.dart';
import 'package:prm_se130184/screens/home.dart';
import 'package:prm_se130184/screens/updateCalamity.dart';
import 'package:prm_se130184/services/project_api.dart';

class CalamityListItem extends StatelessWidget {
  final Calamity calamities;

  CalamityListItem({@required this.calamities});
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Sure"),
      onPressed: () {
        ProjectApi.deleteCalamity(calamities.calamityId);
        Future.delayed(const Duration(milliseconds: 3500), () {
// Here you can write your codec

          Navigator.pop(
            context,
            MaterialPageRoute(builder: (context) => RootScreen()),
          );
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete"),
      content: Text("Do you wanna delete?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => UpdateCalamityScreen(
                    calamity: calamities,
                  )));
        },
        onLongPress: () {
          showAlertDialog(context);
        },
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    right: 10,
                  ),
                  // decoration: BoxDecoration(
                  //     border:
                  //         Border.all(color: Colors.purple[100], width: 2)),
                  height: 140,
                  width: 350,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12)),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                              bottom: 5,
                            ),
                            alignment: Alignment.topLeft,
                          ),
                          SizedBox(
                            height: 45,
                            child: Container(
                              margin: EdgeInsets.only(
                                bottom: 5,
                              ),
                              alignment: Alignment.center,
                              // decoration: BoxDecoration(
                              //  border: Border.all(color: Colors.red)),
                              child: Text(
                                calamities.calamityName != null
                                    ? calamities.calamityName
                                    : "Calamity name",
                                maxLines: 2,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: Container(
                              margin: EdgeInsets.only(
                                bottom: 5,
                              ),
                              alignment: Alignment.topLeft,
                              // decoration: BoxDecoration(
                              //  border: Border.all(color: Colors.red)),
                              child: Text(
                                calamities.description != null
                                    ? calamities.description
                                    : "Calamity description",
                                maxLines: 3,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  wordSpacing: -1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
