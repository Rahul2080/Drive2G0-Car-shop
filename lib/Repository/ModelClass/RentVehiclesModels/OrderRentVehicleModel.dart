
class OrderRentVehicleModel {
  String? id;
  dynamic vehicle;
  String? user;
  String? pickupDate;
  String? returnDate;
  String? pickupLocation;
  String? returnLocation;
  int? amount;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? v;

  OrderRentVehicleModel({this.id, this.vehicle, this.user, this.pickupDate, this.returnDate, this.pickupLocation, this.returnLocation, this.amount, this.status, this.createdAt, this.updatedAt, this.v});

  OrderRentVehicleModel.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    vehicle = json["vehicle"];
    if(json["user"] is String) {
      user = json["user"];
    }
    if(json["pickupDate"] is String) {
      pickupDate = json["pickupDate"];
    }
    if(json["returnDate"] is String) {
      returnDate = json["returnDate"];
    }
    if(json["pickupLocation"] is String) {
      pickupLocation = json["pickupLocation"];
    }
    if(json["returnLocation"] is String) {
      returnLocation = json["returnLocation"];
    }
    if(json["amount"] is num) {
      amount = (json["amount"] as num).toInt();
    }
    if(json["status"] is String) {
      status = json["status"];
    }
    if(json["createdAt"] is String) {
      createdAt = json["createdAt"];
    }
    if(json["updatedAt"] is String) {
      updatedAt = json["updatedAt"];
    }
    if(json["__v"] is num) {
      v = (json["__v"] as num).toInt();
    }
  }

  static List<OrderRentVehicleModel> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => OrderRentVehicleModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["vehicle"] = vehicle;
    _data["user"] = user;
    _data["pickupDate"] = pickupDate;
    _data["returnDate"] = returnDate;
    _data["pickupLocation"] = pickupLocation;
    _data["returnLocation"] = returnLocation;
    _data["amount"] = amount;
    _data["status"] = status;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    _data["__v"] = v;
    return _data;
  }

  OrderRentVehicleModel copyWith({
    String? id,
    dynamic vehicle,
    String? user,
    String? pickupDate,
    String? returnDate,
    String? pickupLocation,
    String? returnLocation,
    int? amount,
    String? status,
    String? createdAt,
    String? updatedAt,
    int? v,
  }) => OrderRentVehicleModel(
    id: id ?? this.id,
    vehicle: vehicle ?? this.vehicle,
    user: user ?? this.user,
    pickupDate: pickupDate ?? this.pickupDate,
    returnDate: returnDate ?? this.returnDate,
    pickupLocation: pickupLocation ?? this.pickupLocation,
    returnLocation: returnLocation ?? this.returnLocation,
    amount: amount ?? this.amount,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    v: v ?? this.v,
  );
}