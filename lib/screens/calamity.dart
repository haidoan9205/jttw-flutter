import 'package:flutter/material.dart';
import 'package:prm_se130184/color.dart';
import 'package:prm_se130184/model/calamity.dart';
import 'package:prm_se130184/presenter/calamity_presenter.dart';
import 'package:prm_se130184/screens/createCalamity.dart';
import 'package:prm_se130184/views/calamity_view.dart';
// import 'package:prm_se130184/widgets/actor_list.dart';
import 'package:prm_se130184/widgets/calamity_list.dart';

class CalamityRootScreen extends StatefulWidget {
  CalamityRootScreen({Key key}) : super(key: key);

  @override
  CalamityRootScreenState createState() => CalamityRootScreenState();
}

class CalamityRootScreenState extends State<CalamityRootScreen> {
  List<Widget> screens = <Widget>[
    CalamityScreen(),
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
      // bottomNavigationBar:
      //     BottomBar(currentIndex: _currentIndex, onTap: _onItemTapped),
    );
  }
}

class CalamityScreen extends StatefulWidget {
  // Future<List<Actor>> _actor;
  CalamityScreen({Key key}) : super(key: key);

  @override
  _CalamityScreenState createState() => _CalamityScreenState();
}

class _CalamityScreenState extends State<CalamityScreen>
    implements CalamityView {
  Future<List<Calamity>> _calamity;
  CalamityPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = new CalamityPresenter();
    _presenter.attachView(this);
    _presenter.getCalamities();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => CreateCalamityScreen()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      appBar: AppBar(
        title: Text(
          "Calamities",
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
          child: FutureBuilder<List<Calamity>>(
            future: _calamity,
            builder:
                (BuildContext context, AsyncSnapshot<List<Calamity>> snapshot) {
              if (snapshot.hasError)
                return Text("There was an error: ${snapshot.error}");
              if (snapshot.hasData) {
                var calamitydata = snapshot.data;
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: calamitydata == null ? 0 : calamitydata.length,
                  itemBuilder: (_, int index) {
                    var calamity = calamitydata[index];
                    return CalamityListItem(calamities: calamity);
                  },
                );
              } else {
                return Text("Wait");
              }
              ;
            },
          ),
        )),
      ),
    );
  }

  @override
  onLoadCalamities(Future<List<Calamity>> calamity) {
    setState(() {
      _calamity = calamity;
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
