class UserbyUserIdPasswordModel {
  UserbyUserIdPasswordModel({
      this.id, 
      this.fullName, 
      this.email, 
      this.phone, 
      this.profilePhoto, 
      this.fcmToken, 
      this.resetPasswordToken, 
      this.resetPasswordExpires, 
      this.v, 
      this.profilePhotoUrl,});

  UserbyUserIdPasswordModel.fromJson(dynamic json) {
    id = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    phone = json['phone'];
    profilePhoto = json['profilePhoto'];
    fcmToken = json['fcmToken'];
    resetPasswordToken = json['resetPasswordToken'];
    resetPasswordExpires = json['resetPasswordExpires'];
    v = json['__v'];
    profilePhotoUrl = json['profilePhotoUrl'];
  }
  String? id;
  String? fullName;
  String? email;
  String? phone;
  dynamic profilePhoto;
  String? fcmToken;
  String? resetPasswordToken;
  String? resetPasswordExpires;
  int? v;
  dynamic profilePhotoUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['fullName'] = fullName;
    map['email'] = email;
    map['phone'] = phone;
    map['profilePhoto'] = profilePhoto;
    map['fcmToken'] = fcmToken;
    map['resetPasswordToken'] = resetPasswordToken;
    map['resetPasswordExpires'] = resetPasswordExpires;
    map['__v'] = v;
    map['profilePhotoUrl'] = profilePhotoUrl;
    return map;
  }

}