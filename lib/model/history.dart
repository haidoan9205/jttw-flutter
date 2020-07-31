class History {
  int id;
  int userId;
  int calamityId;
  int equipmentId;
  int actorId;
  String time;

  History(
      {this.id,
      this.userId,
      this.calamityId,
      this.equipmentId,
      this.actorId,
      this.time});

  History.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    calamityId = json['calamityId'];
    equipmentId = json['equipmentId'];
    actorId = json['actorId'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['calamityId'] = this.calamityId;
    data['equipmentId'] = this.equipmentId;
    data['actorId'] = this.actorId;
    data['time'] = this.time;
    return data;
  }
}
