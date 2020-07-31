// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prm_se130184/model/actor.dart';
import 'package:prm_se130184/screens/home.dart';
import 'package:prm_se130184/screens/updateActor.dart';
import 'package:prm_se130184/services/project_api.dart';

class ActorListItem extends StatelessWidget {
  final Actor actors;

  ActorListItem({@required this.actors});
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
        ProjectApi.deleteActor(actors.actorId);
        Future.delayed(const Duration(milliseconds: 5000), () {
// Here you can write your code

          Navigator.push(
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
    if (!actors.isActive) {
      return Container(
        width: 0,
        height: 0,
      );
    } else {
      return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => UpdateActorScreen(
                      actor: actors,
                    )));
          },
          onLongPress: () {
            showAlertDialog(context);
          },
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Stack(children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                      height: 140,
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: actors.image != null
                              ? NetworkImage(actors.image)
                              : AssetImage("assets/images/empty.png"),
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ]),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10,
                      right: 10,
                    ),
                    // decoration: BoxDecoration(
                    //     border:
                    //         Border.all(color: Colors.purple[100], width: 2)),
                    height: 140,
                    width: 170,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 5,
                          ),
                          alignment: Alignment.topLeft,
                          //decoration: BoxDecoration(
                          //  border: Border.all(color: Colors.grey)),
                          // Text(
                          //   "Công nghệ",
                          //   style: TextStyle(
                          //       backgroundColor: Colors.brown[50],
                          //       color: Colors.red[200],
                          //       fontWeight: FontWeight.bold,
                          //       fontSize: 13),
                          // ),
                        ),
                        SizedBox(
                          height: 45,
                          child: Container(
                            margin: EdgeInsets.only(
                              bottom: 5,
                            ),
                            alignment: Alignment.topLeft,
                            // decoration: BoxDecoration(
                            //  border: Border.all(color: Colors.red)),
                            child: Text(
                              actors.actorName != null
                                  ? actors.actorName
                                  : "Actor name",
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
                              actors.description != null
                                  ? actors.description
                                  : "Actor description",
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
                  )
                ],
              ),
            ],
          ));
    }
  }
}
