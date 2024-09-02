class OrderRentVehicleModel {
  OrderRentVehicleModel({
      this.vehicle, 
      this.user, 
      this.pickupDate, 
      this.returnDate, 
      this.pickupLocation, 
      this.returnLocation, 
      this.amount, 
      this.status, 
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  OrderRentVehicleModel.fromJson(dynamic json) {
    vehicle = json['vehicle'];
    user = json['user'];
    pickupDate = json['pickupDate'];
    returnDate = json['returnDate'];
    pickupLocation = json['pickupLocation'];
    returnLocation = json['returnLocation'];
    amount = json['amount'];
    status = json['status'];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? vehicle;
  String? user;
  String? pickupDate;
  String? returnDate;
  String? pickupLocation;
  String? returnLocation;
  int? amount;
  String? status;
  String? id;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['vehicle'] = vehicle;
    map['user'] = user;
    map['pickupDate'] = pickupDate;
    map['returnDate'] = returnDate;
    map['pickupLocation'] = pickupLocation;
    map['returnLocation'] = returnLocation;
    map['amount'] = amount;
    map['status'] = status;
    map['_id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}