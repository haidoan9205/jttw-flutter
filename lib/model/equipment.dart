class Equipment {
  int equipmentId;
  String equipmentName;
  String description;
  int quantity;
  bool isActive;
  String image;

  Equipment(
      {this.equipmentId,
      this.equipmentName,
      this.description,
      this.quantity,
      this.isActive,
      this.image});

  Equipment.fromJson(Map<String, dynamic> json) {
    equipmentId = json['equipmentId'];
    equipmentName = json['equipmentName'];
    description = json['description'];
    quantity = json['quantity'];
    isActive = json['isActive'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['equipmentId'] = this.equipmentId;
    data['equipmentName'] = this.equipmentName;
    data['description'] = this.description;
    data['quantity'] = this.quantity;
    data['isActive'] = this.isActive;
    data['image'] = this.image;
    return data;
  }
}