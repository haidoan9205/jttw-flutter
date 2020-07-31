import 'package:prm_se130184/model/actor.dart';
import 'package:prm_se130184/presenter/base_presenter.dart';
import 'package:prm_se130184/services/project_api.dart';
import 'package:prm_se130184/views/actor_view.dart';

class ActorPresenter extends BasePresenter<ActorView> {
  final ProjectApi apiScv = new ProjectApi();

  Future<List<Actor>> getActors() async {
    checkViewAttached();
    Future<List<Actor>> actors = apiScv?.getActors();
    //print(news[0].newsTitle);
    if (actors != null) {
      isViewAttached ? getView().onLoadActors(actors) : null;
    } else {
      //return debugPrint("News is empty!");
      throw Exception('Actor is empty!');
    }
    return actors;
  }
}
