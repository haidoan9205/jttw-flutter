class Calamity {
  int calamityId;
  String calamityName;
  String description;
  String location;
  String startTime;
  String endTime;
  int numberOfFilming;
  String roleSpecification;
  int status;
  bool isActive;
  int actorId;
  int equipmentId;

  Calamity(
      {this.calamityId,
      this.calamityName,
      this.description,
      this.location,
      this.startTime,
      this.endTime,
      this.numberOfFilming,
      this.roleSpecification,
      this.status,
      this.isActive,
      this.actorId,
      this.equipmentId});

  Calamity.fromJson(Map<String, dynamic> json) {
    calamityId = json['calamityId'];
    calamityName = json['calamityName'];
    description = json['description'];
    location = json['location'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    numberOfFilming = json['numberOfFilming'];
    roleSpecification = json['roleSpecification'];
    status = json['status'];
    isActive = json['isActive'];
    actorId = json['actorId'];
    equipmentId = json['equipmentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['calamityId'] = this.calamityId;
    data['calamityName'] = this.calamityName;
    data['description'] = this.description;
    data['location'] = this.location;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['numberOfFilming'] = this.numberOfFilming;
    data['roleSpecification'] = this.roleSpecification;
    data['status'] = this.status;
    data['isActive'] = this.isActive;
    data['actorId'] = this.actorId;
    data['equipment.dart'] = this.equipmentId;
    return data;
  }
}
