import 'package:prm_se130184/model/calamity.dart';

abstract class CalamityView {
  onLoadCalamities(Future<List<Calamity>> calamity);
}
