import 'package:prm_se130184/model/history.dart';

abstract class HistoryView {
  onLoadHistories(Future<List<History>> history);
}
