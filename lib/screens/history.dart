import 'package:flutter/material.dart';
import 'package:prm_se130184/model/history.dart';
import 'package:prm_se130184/presenter/history_presenter.dart';
import 'package:prm_se130184/screens/createCalamity.dart';
import 'package:prm_se130184/views/history_view.dart'; /*  */
import 'package:prm_se130184/widgets/history_list.dart';

class HistoryRootScreen extends StatefulWidget {
  HistoryRootScreen({Key key}) : super(key: key);

  @override
  HistoryRootScreenState createState() => HistoryRootScreenState();
}

class HistoryRootScreenState extends State<HistoryRootScreen> {
  List<Widget> screens = <Widget>[
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
      // bottomNavigationBar:
      //     BottomBar(currentIndex: _currentIndex, onTap: _onItemTapped),
    );
  }
}

class HistoryScreen extends StatefulWidget {
  // Future<List<Actor>> _actor;
  HistoryScreen({Key key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> implements HistoryView {
  Future<List<History>> _history;
  HistoryPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = new HistoryPresenter();
    _presenter.attachView(this);
    _presenter.getHistories();
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
          "Activities",
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
          child: FutureBuilder<List<History>>(
            future: _history,
            builder:
                (BuildContext context, AsyncSnapshot<List<History>> snapshot) {
              if (snapshot.hasError)
                return Text("There was an error: ${snapshot.error}");
              if (snapshot.hasData) {
                var historydata = snapshot.data;
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: historydata == null ? 0 : historydata.length,
                  itemBuilder: (_, int index) {
                    var history = historydata[index];
                    return HistoryListItem(histories: history);
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
  onLoadHistories(Future<List<History>> history) {
    setState(() {
      _history = history;
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
