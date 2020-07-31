import 'package:prm_se130184/model/equipment.dart';

abstract class EquipmentView {
  onLoadEquipments(Future<List<Equipment>> equipment);
}
