import 'package:prm_se130184/model/calamity.dart';
import 'package:prm_se130184/presenter/base_presenter.dart';
import 'package:prm_se130184/services/project_api.dart';
import 'package:prm_se130184/views/calamity_view.dart';

class CalamityPresenter extends BasePresenter<CalamityView> {
  final ProjectApi apiScv = new ProjectApi();

  Future<List<Calamity>> getCalamities() async {
    checkViewAttached();
    Future<List<Calamity>> calamities = apiScv?.getCalamities();
    //print(news[0].newsTitle);
    if (calamities != null) {
      isViewAttached ? getView().onLoadCalamities(calamities) : null;
    } else {
      throw Exception('Calamity is empty!');
    }
    return calamities;
  }
}
