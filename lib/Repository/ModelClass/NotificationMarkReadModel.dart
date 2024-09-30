class NotificationMarkReadModel {
  NotificationMarkReadModel({
      this.message, 
      this.data,});

  NotificationMarkReadModel.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      this.id, 
      this.user, 
      this.title, 
      this.message, 
      this.isRead, 
      this.buyVehicleId, 
      this.rentVehicleId, 
      this.sentAt, 
      this.v,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    user = json['user'];
    title = json['title'];
    message = json['message'];
    isRead = json['isRead'];
    buyVehicleId = json['buyVehicleId'];
    rentVehicleId = json['rentVehicleId'];
    sentAt = json['sentAt'];
    v = json['__v'];
  }
  String? id;
  String? user;
  String? title;
  String? message;
  bool? isRead;
  dynamic buyVehicleId;
  String? rentVehicleId;
  String? sentAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['user'] = user;
    map['title'] = title;
    map['message'] = message;
    map['isRead'] = isRead;
    map['buyVehicleId'] = buyVehicleId;
    map['rentVehicleId'] = rentVehicleId;
    map['sentAt'] = sentAt;
    map['__v'] = v;
    return map;
  }

}