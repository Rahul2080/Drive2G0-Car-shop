
class SearchRentVehiclesModel {
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
  int? v;

  SearchRentVehiclesModel({this.location, this.id, this.brand, this.model, this.description, this.rentPrice, this.mileage, this.photos, this.vehicleColor, this.gearType, this.fuelType, this.noOfSeats, this.rating, this.noOfDoors, this.ownerName, this.ownerPhoneNumber, this.ownerPlace, this.ownerProfilePhoto, this.available, this.v});

  SearchRentVehiclesModel.fromJson(Map<String, dynamic> json) {
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
    if(json["__v"] is num) {
      v = (json["__v"] as num).toInt();
    }
  }

  static List<SearchRentVehiclesModel> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => SearchRentVehiclesModel.fromJson(map)).toList();
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
    _data["__v"] = v;
    return _data;
  }
  static List<SearchRentVehiclesModel> listFromJson(List<dynamic> json) {
    return json == null
        ? []
        : json.map((value) => SearchRentVehiclesModel.fromJson(value)).toList();
  }
  SearchRentVehiclesModel copyWith({
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
    int? v,
  }) => SearchRentVehiclesModel(
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