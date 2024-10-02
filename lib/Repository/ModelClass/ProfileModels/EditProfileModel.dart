class EditProfileModel {
  EditProfileModel({
      this.id, 
      this.fullName, 
      this.email, 
      this.phone, 
      this.v, 
      this.profilePhoto, 
      this.profilePhotoUrl,});

  EditProfileModel.fromJson(dynamic json) {
    id = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    phone = json['phone'];
    v = json['__v'];
    profilePhoto = json['profilePhoto'];
    profilePhotoUrl = json['profilePhotoUrl'];
  }
  String? id;
  String? fullName;
  String? email;
  String? phone;
  int? v;
  String? profilePhoto;
  String? profilePhotoUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
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