class Actor {
  int actorId;
  String actorName;
  String image;
  String description;
  String phone;
  String email;
  bool isActive;

  Actor(
      {this.actorId,
      this.actorName,
      this.image,
      this.description,
      this.phone,
      this.email,
      this.isActive});

  Actor.fromJson(Map<String, dynamic> json) {
    actorId = json['actorId'];
    actorName = json['actorName'];
    image = json['image'];
    description = json['description'];
    phone = json['phone'];
    email = json['email'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['actorId'] = this.actorId;
    data['actorName'] = this.actorName;
    data['image'] = this.image;
    data['description'] = this.description;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['isActive'] = this.isActive;
    return data;
  }
}
