import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prm_se130184/model/history.dart';

class HistoryListItem extends StatelessWidget {
  final History histories;

  HistoryListItem({@required this.histories});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Table(
//          defaultColumnWidth:
//              FixedColumnWidth(MediaQuery.of(context).size.width / 3),
        border: TableBorder.all(
            color: Colors.black26, width: 3, style: BorderStyle.none),
        children: [
          TableRow(children: [
            TableCell(child: Center(child: Text('Calamity Id'))),
            TableCell(
              child: Center(child: Text('Actor Id')),
            ),
            TableCell(child: Center(child: Text('Equipment Id'))),
            TableCell(child: Center(child: Text('Start time'))),
          ]),
          TableRow(children: [
            TableCell(
                child: Center(
              child: Text(
                histories.calamityId.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            )),
            TableCell(
              child: Center(
                  child: Text(
                histories.actorId.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                ),
              )),
            ),
            TableCell(
                child: Center(
              child: Text(
                histories.equipmentId.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                ),
              ),
            )),
            TableCell(
                child: Center(
              child: Text(
                histories.time,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                ),
              ),
            )),
          ])
        ],
      ),
    );

    //  GestureDetector(
    //     child: Column(

    //   children: <Widget>[
    //     Row(
    //       children: <Widget>[
    //         Container(
    //           margin: EdgeInsets.only(
    //             top: 10,
    //             right: 10,
    //           ),
    //           // decoration: BoxDecoration(
    //           //     border:
    //           //         Border.all(color: Colors.purple[100], width: 2)),
    //           height: 140,
    //           width: 170,
    //           child: Column(
    //             children: <Widget>[
    //               SizedBox(
    //                 height: 45,
    //                 child: Container(
    //                   margin: EdgeInsets.only(
    //                     bottom: 5,
    //                   ),
    //                   alignment: Alignment.topLeft,
    //                   // decoration: BoxDecoration(
    //                   //  border: Border.all(color: Colors.red)),
    //                   child: Text(
    //                     histories.calamityId.toString(),
    //                     style: TextStyle(
    //                       color: Colors.black,
    //                       fontSize: 12,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 50,
    //                 child: Container(
    //                   margin: EdgeInsets.only(
    //                     bottom: 5,
    //                   ),
    //                   alignment: Alignment.topLeft,
    //                   // decoration: BoxDecoration(
    //                   //  border: Border.all(color: Colors.red)),
    //                   child: Text(
    //                     histories.actorId.toString(),
    //                     style: TextStyle(
    //                       color: Colors.black,
    //                       fontSize: 13,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 50,
    //                 child: Container(
    //                   margin: EdgeInsets.only(
    //                     bottom: 5,
    //                   ),
    //                   alignment: Alignment.topLeft,
    //                   // decoration: BoxDecoration(
    //                   //  border: Border.all(color: Colors.red)),
    //                   child: Text(
    //                     histories.equipmentId.toString(),
    //                     style: TextStyle(
    //                       color: Colors.black,
    //                       fontSize: 13,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(
    //                 child: Container(
    //                   margin: EdgeInsets.only(
    //                     bottom: 5,
    //                   ),
    //                   alignment: Alignment.topLeft,
    //                   // decoration: BoxDecoration(
    //                   //  border: Border.all(color: Colors.red)),
    //                   child: Text(
    //                     histories.time,
    //                     style: TextStyle(
    //                       color: Colors.black,
    //                       fontSize: 13,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         )
    //       ],
    //     ),
    //   ],
    // ));
  }
}
