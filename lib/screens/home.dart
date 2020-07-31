import 'package:flutter/material.dart';
import 'package:prm_se130184/color.dart';
import 'package:prm_se130184/model/actor.dart';
import 'package:prm_se130184/model/equipment.dart';
import 'package:prm_se130184/presenter/actor_presenter.dart';
import 'package:prm_se130184/screens/calamity.dart';
import 'package:prm_se130184/screens/createActor.dart';
import 'package:prm_se130184/screens/equipment.dart';
import 'package:prm_se130184/screens/history.dart';
import 'package:prm_se130184/views/actor_view.dart';
import 'package:prm_se130184/widgets/actor_list.dart';
import 'package:prm_se130184/widgets/bottom_bar.dart';

class RootScreen extends StatefulWidget {
  RootScreen({Key key}) : super(key: key);

  @override
  RootScreenState createState() => RootScreenState();
}

class RootScreenState extends State<RootScreen> {
  List<Widget> screens = <Widget>[
    HomeScreen(),
    EquipmentScreen(),
    CalamityScreen(),
    HistoryScreen(),
    // ProfileScreen(_user, _googleSignIn),
    // ProfileScreen(),
  ];

  int _currentIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: screens.elementAt(_currentIndex),
      bottomNavigationBar:
          BottomBar(currentIndex: _currentIndex, onTap: _onItemTapped),
    );
  }
}

class HomeScreen extends StatefulWidget {
  // Future<List<Actor>> _actor;
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements ActorView {
  Future<List<Actor>> _actor;
  ActorPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = new ActorPresenter();
    _presenter.attachView(this);
    _presenter.getActors();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => CreateActorScreen()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      appBar: AppBar(
        title: Text(
          "Actors",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Center(
            child: Container(
          child: FutureBuilder<List<Actor>>(
            future: _actor,
            builder:
                (BuildContext context, AsyncSnapshot<List<Actor>> snapshot) {
              if (snapshot.hasError)
                return Text("There was an error: ${snapshot.error}");
              if (snapshot.hasData) {
                var actordata = snapshot.data;
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: actordata == null ? 0 : actordata.length,
                  itemBuilder: (_, int index) {
                    var actors = actordata[index];
                    return ActorListItem(actors: actors);
                  },
                );
              } else {
                return Text("Wait");
              }
            },
          ),
        )),
      ),
      // bottomNavigationBar:
      //     BottomNavigationBar(selectedItemColor: primaryColor, items: [
      //   new BottomNavigationBarItem(
      //       icon: Icon(Icons.home), title: Text("Home")),
      //   new BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.desktop_windows,
      //         color: Colors.black54,
      //       ),
      //       title: Text("Channel")),
      //   new BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.person,
      //         color: Colors.black54,
      //       ),
      //       title: Text("Profile")),
      //   new BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.edit,
      //         color: Colors.black54,
      //       ),
      //       title: Text("Equipment"))
      // ]),
    );
  }

  @override
  onLoadActors(Future<List<Actor>> actor) {
    setState(() {
      _actor = actor;
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_presenter != null) {
      _presenter.detachView();
    }
  }
}
