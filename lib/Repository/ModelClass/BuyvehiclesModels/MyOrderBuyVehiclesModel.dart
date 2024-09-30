
class MyOrderBuyVehiclesModel {
  String? id;
  String? buyer;
  String? buyerName;
  String? buyerPhoneNumber;
  String? buyerEmail;
  String? buyerAddress;
  Vehicle? vehicle;
  int? purchasePrice;
  String? paymentStatus;
  String? deliveryStatus;
  String? purchaseDate;
  int? v;

  MyOrderBuyVehiclesModel({this.id, this.buyer, this.buyerName, this.buyerPhoneNumber, this.buyerEmail, this.buyerAddress, this.vehicle, this.purchasePrice, this.paymentStatus, this.deliveryStatus, this.purchaseDate, this.v});

  MyOrderBuyVehiclesModel.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["buyer"] is String) {
      buyer = json["buyer"];
    }
    if(json["buyerName"] is String) {
      buyerName = json["buyerName"];
    }
    if(json["buyerPhoneNumber"] is String) {
      buyerPhoneNumber = json["buyerPhoneNumber"];
    }
    if(json["buyerEmail"] is String) {
      buyerEmail = json["buyerEmail"];
    }
    if(json["buyerAddress"] is String) {
      buyerAddress = json["buyerAddress"];
    }
    if(json["vehicle"] is Map) {
      vehicle = json["vehicle"] == null ? null : Vehicle.fromJson(json["vehicle"]);
    }
    if(json["purchasePrice"] is num) {
      purchasePrice = (json["purchasePrice"] as num).toInt();
    }
    if(json["paymentStatus"] is String) {
      paymentStatus = json["paymentStatus"];
    }
    if(json["deliveryStatus"] is String) {
      deliveryStatus = json["deliveryStatus"];
    }
    if(json["purchaseDate"] is String) {
      purchaseDate = json["purchaseDate"];
    }
    if(json["__v"] is num) {
      v = (json["__v"] as num).toInt();
    }
  }

  static List<MyOrderBuyVehiclesModel> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => MyOrderBuyVehiclesModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["buyer"] = buyer;
    _data["buyerName"] = buyerName;
    _data["buyerPhoneNumber"] = buyerPhoneNumber;
    _data["buyerEmail"] = buyerEmail;
    _data["buyerAddress"] = buyerAddress;
    if(vehicle != null) {
      _data["vehicle"] = vehicle?.toJson();
    }
    _data["purchasePrice"] = purchasePrice;
    _data["paymentStatus"] = paymentStatus;
    _data["deliveryStatus"] = deliveryStatus;
    _data["purchaseDate"] = purchaseDate;
    _data["__v"] = v;
    return _data;
  }
  static List<MyOrderBuyVehiclesModel> listFromJson(List<dynamic> json) {
    return json == null
        ? []
        : json.map((value) => MyOrderBuyVehiclesModel.fromJson(value)).toList();
  }

  MyOrderBuyVehiclesModel copyWith({
    String? id,
    String? buyer,
    String? buyerName,
    String? buyerPhoneNumber,
    String? buyerEmail,
    String? buyerAddress,
    Vehicle? vehicle,
    int? purchasePrice,
    String? paymentStatus,
    String? deliveryStatus,
    String? purchaseDate,
    int? v,
  }) => MyOrderBuyVehiclesModel(
    id: id ?? this.id,
    buyer: buyer ?? this.buyer,
    buyerName: buyerName ?? this.buyerName,
    buyerPhoneNumber: buyerPhoneNumber ?? this.buyerPhoneNumber,
    buyerEmail: buyerEmail ?? this.buyerEmail,
    buyerAddress: buyerAddress ?? this.buyerAddress,
    vehicle: vehicle ?? this.vehicle,
    purchasePrice: purchasePrice ?? this.purchasePrice,
    paymentStatus: paymentStatus ?? this.paymentStatus,
    deliveryStatus: deliveryStatus ?? this.deliveryStatus,
    purchaseDate: purchaseDate ?? this.purchaseDate,
    v: v ?? this.v,
  );
}

class Vehicle {
  Location? location;
  String? id;
  String? brand;
  String? model;
  String? description;
  int? rentPrice;
  int? mileage;
  List<String>? photos;
  String? vehicleColor;
  String? gearType;
  String? fuelType;
  int? noOfSeats;
  double? rating;
  int? noOfDoors;
  String? ownerName;
  String? ownerPhoneNumber;
  String? ownerPlace;
  String? ownerProfilePhoto;
  bool? available;
  bool? latestModel;
  bool? highMilage;
  int? v;

  Vehicle({this.location, this.id, this.brand, this.model, this.description, this.rentPrice, this.mileage, this.photos, this.vehicleColor, this.gearType, this.fuelType, this.noOfSeats, this.rating, this.noOfDoors, this.ownerName, this.ownerPhoneNumber, this.ownerPlace, this.ownerProfilePhoto, this.available, this.latestModel, this.highMilage, this.v});

  Vehicle.fromJson(Map<String, dynamic> json) {
    if(json["location"] is Map) {
      location = json["location"] == null ? null : Location.fromJson(json["location"]);
    }
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["brand"] is String) {
      brand = json["brand"];
    }
    if(json["model"] is String) {
      model = json["model"];
    }
    if(json["description"] is String) {
      description = json["description"];
    }
    if(json["rentPrice"] is num) {
      rentPrice = (json["rentPrice"] as num).toInt();
    }
    if(json["mileage"] is num) {
      mileage = (json["mileage"] as num).toInt();
    }
    if(json["photos"] is List) {
      photos = json["photos"] == null ? null : List<String>.from(json["photos"]);
    }
    if(json["vehicleColor"] is String) {
      vehicleColor = json["vehicleColor"];
    }
    if(json["gearType"] is String) {
      gearType = json["gearType"];
    }
    if(json["fuelType"] is String) {
      fuelType = json["fuelType"];
    }
    if(json["noOfSeats"] is num) {
      noOfSeats = (json["noOfSeats"] as num).toInt();
    }
    if(json["rating"] is num) {
      rating = (json["rating"] as num).toDouble();
    }
    if(json["noOfDoors"] is num) {
      noOfDoors = (json["noOfDoors"] as num).toInt();
    }
    if(json["ownerName"] is String) {
      ownerName = json["ownerName"];
    }
    if(json["ownerPhoneNumber"] is String) {
      ownerPhoneNumber = json["ownerPhoneNumber"];
    }
    if(json["ownerPlace"] is String) {
      ownerPlace = json["ownerPlace"];
    }
    if(json["ownerProfilePhoto"] is String) {
      ownerProfilePhoto = json["ownerProfilePhoto"];
    }
    if(json["available"] is bool) {
      available = json["available"];
    }
    if(json["latestModel"] is bool) {
      latestModel = json["latestModel"];
    }
    if(json["highMilage"] is bool) {
      highMilage = json["highMilage"];
    }
    if(json["__v"] is num) {
      v = (json["__v"] as num).toInt();
    }
  }

  static List<Vehicle> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => Vehicle.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(location != null) {
      _data["location"] = location?.toJson();
    }
    _data["_id"] = id;
    _data["brand"] = brand;
    _data["model"] = model;
    _data["description"] = description;
    _data["rentPrice"] = rentPrice;
    _data["mileage"] = mileage;
    if(photos != null) {
      _data["photos"] = photos;
    }
    _data["vehicleColor"] = vehicleColor;
    _data["gearType"] = gearType;
    _data["fuelType"] = fuelType;
    _data["noOfSeats"] = noOfSeats;
    _data["rating"] = rating;
    _data["noOfDoors"] = noOfDoors;
    _data["ownerName"] = ownerName;
    _data["ownerPhoneNumber"] = ownerPhoneNumber;
    _data["ownerPlace"] = ownerPlace;
    _data["ownerProfilePhoto"] = ownerProfilePhoto;
    _data["available"] = available;
    _data["latestModel"] = latestModel;
    _data["highMilage"] = highMilage;
    _data["__v"] = v;
    return _data;
  }

  Vehicle copyWith({
    Location? location,
    String? id,
    String? brand,
    String? model,
    String? description,
    int? rentPrice,
    int? mileage,
    List<String>? photos,
    String? vehicleColor,
    String? gearType,
    String? fuelType,
    int? noOfSeats,
    double? rating,
    int? noOfDoors,
    String? ownerName,
    String? ownerPhoneNumber,
    String? ownerPlace,
    String? ownerProfilePhoto,
    bool? available,
    bool? latestModel,
    bool? highMilage,
    int? v,
  }) => Vehicle(
    location: location ?? this.location,
    id: id ?? this.id,
    brand: brand ?? this.brand,
    model: model ?? this.model,
    description: description ?? this.description,
    rentPrice: rentPrice ?? this.rentPrice,
    mileage: mileage ?? this.mileage,
    photos: photos ?? this.photos,
    vehicleColor: vehicleColor ?? this.vehicleColor,
    gearType: gearType ?? this.gearType,
    fuelType: fuelType ?? this.fuelType,
    noOfSeats: noOfSeats ?? this.noOfSeats,
    rating: rating ?? this.rating,
    noOfDoors: noOfDoors ?? this.noOfDoors,
    ownerName: ownerName ?? this.ownerName,
    ownerPhoneNumber: ownerPhoneNumber ?? this.ownerPhoneNumber,
    ownerPlace: ownerPlace ?? this.ownerPlace,
    ownerProfilePhoto: ownerProfilePhoto ?? this.ownerProfilePhoto,
    available: available ?? this.available,
    latestModel: latestModel ?? this.latestModel,
    highMilage: highMilage ?? this.highMilage,
    v: v ?? this.v,
  );
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    if(json["type"] is String) {
      type = json["type"];
    }
    if(json["coordinates"] is List) {
      coordinates = json["coordinates"] == null ? null : List<double>.from(json["coordinates"]);
    }
  }

  static List<Location> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => Location.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["type"] = type;
    if(coordinates != null) {
      _data["coordinates"] = coordinates;
    }
    return _data;
  }

  Location copyWith({
    String? type,
    List<double>? coordinates,
  }) => Location(
    type: type ?? this.type,
    coordinates: coordinates ?? this.coordinates,
  );
}