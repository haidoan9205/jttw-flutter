import 'package:prm_se130184/model/actor.dart';

abstract class ActorView {
  onLoadActors(Future<List<Actor>> actor);
}
