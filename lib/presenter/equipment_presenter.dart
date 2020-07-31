import 'package:prm_se130184/model/equipment.dart';
import 'package:prm_se130184/presenter/base_presenter.dart';
import 'package:prm_se130184/services/project_api.dart';
import 'package:prm_se130184/views/equipment_view.dart';

class EquipmentPresenter extends BasePresenter<EquipmentView> {
  final ProjectApi apiScv = new ProjectApi();

  Future<List<Equipment>> getEquipments() async {
    checkViewAttached();
    Future<List<Equipment>> equipments = apiScv?.getEquipments();
    //print(news[0].newsTitle);
    if (equipments != null) {
      isViewAttached ? getView().onLoadEquipments(equipments) : null;
    } else {
      throw Exception('Equipement is empty!');
    }
  }
}
