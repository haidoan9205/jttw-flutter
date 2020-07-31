import 'package:flutter/material.dart';
import 'package:prm_se130184/color.dart';
import 'package:prm_se130184/model/equipment.dart';
import 'package:prm_se130184/presenter/equipment_presenter.dart';
import 'package:prm_se130184/screens/createEquipment.dart';
import 'package:prm_se130184/views/equipment_view.dart';
// import 'package:prm_se130184/widgets/actor_list.dart';
import 'package:prm_se130184/widgets/equipment_list.dart';

class EquipmentRootScreen extends StatefulWidget {
  EquipmentRootScreen({Key key}) : super(key: key);

  @override
  EquipmentRootScreenState createState() => EquipmentRootScreenState();
}

class EquipmentRootScreenState extends State<EquipmentRootScreen> {
  List<Widget> screens = <Widget>[
    EquipmentScreen(),
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

class EquipmentScreen extends StatefulWidget {
  // Future<List<Actor>> _actor;
  EquipmentScreen({Key key}) : super(key: key);

  @override
  _EquipmentScreenState createState() => _EquipmentScreenState();
}

class _EquipmentScreenState extends State<EquipmentScreen>
    implements EquipmentView {
  Future<List<Equipment>> _equipment;
  EquipmentPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = new EquipmentPresenter();
    _presenter.attachView(this);
    _presenter.getEquipments();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => CreateEquipmentScreen()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      appBar: AppBar(
        title: Text(
          "Equipments",
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
          child: FutureBuilder<List<Equipment>>(
            future: _equipment,
            builder: (BuildContext context,
                AsyncSnapshot<List<Equipment>> snapshot) {
              if (snapshot.hasError)
                return Text("There was an error: ${snapshot.error}");
              if (snapshot.hasData) {
                var equipmentdata = snapshot.data;
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: equipmentdata == null ? 0 : equipmentdata.length,
                  itemBuilder: (_, int index) {
                    var equipment = equipmentdata[index];
                    return EquipmentListItem(equipments: equipment);
                  },
                );
              } else {
                return Text("Wait");
              }
            },
          ),
        )),
      ),
    );
  }

  @override
  onLoadEquipments(Future<List<Equipment>> equipment) {
    setState(() {
      _equipment = equipment;
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
