import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int index) onTap;
  const BottomBar({
    Key key,
    @required this.currentIndex,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedIconTheme: IconThemeData(size: 30),
      showSelectedLabels: true,
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.people), title: Text("Actors")),
        BottomNavigationBarItem(
            icon: Icon(Icons.pan_tool), title: Text("Equipments")),
        BottomNavigationBarItem(
          icon: Icon(Icons.sentiment_dissatisfied),
          title: Text("Calamities"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          title: Text("Activities"),
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Colors.amber[800],
      onTap: onTap,
    );
  }
}
