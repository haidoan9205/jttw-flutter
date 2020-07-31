import 'package:prm_se130184/model/history.dart';
import 'package:prm_se130184/presenter/base_presenter.dart';
import 'package:prm_se130184/services/project_api.dart';
import 'package:prm_se130184/views/history_view.dart';

class HistoryPresenter extends BasePresenter<HistoryView> {
  final ProjectApi apiScv = new ProjectApi();

  Future<List<History>> getHistories() async {
    checkViewAttached();
    Future<List<History>> histories = apiScv?.getHistories();
    //print(news[0].newsTitle);
    if (histories != null) {
      isViewAttached ? getView().onLoadHistories(histories) : null;
    } else {
      throw Exception('Histories is empty!');
    }
  }
}
