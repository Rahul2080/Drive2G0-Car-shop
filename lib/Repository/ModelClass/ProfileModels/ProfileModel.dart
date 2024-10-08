class ProfileModel {
  ProfileModel({
      this.resetPasswordToken, 
      this.resetPasswordExpires, 
      this.id, 
      this.fullName, 
      this.email, 
      this.phone, 
      this.v, 
      this.profilePhoto, 
      this.profilePhotoUrl,});

  ProfileModel.fromJson(dynamic json) {
    resetPasswordToken = json['resetPasswordToken'];
    resetPasswordExpires = json['resetPasswordExpires'];
    id = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    phone = json['phone'];
    v = json['__v'];
    profilePhoto = json['profilePhoto'];
    profilePhotoUrl = json['profilePhotoUrl'];
  }
  dynamic resetPasswordToken;
  dynamic resetPasswordExpires;
  String? id;
  String? fullName;
  String? email;
  String? phone;
  int? v;
  String? profilePhoto;
  String? profilePhotoUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['resetPasswordToken'] = resetPasswordToken;
    map['resetPasswordExpires'] = resetPasswordExpires;
    map['_id'] = id;
    map['fullName'] = fullName;
    map['email'] = email;
    map['phone'] = phone;
    map['__v'] = v;
    map['profilePhoto'] = profilePhoto;
    map['profilePhotoUrl'] = profilePhotoUrl;
    return map;
  }

}