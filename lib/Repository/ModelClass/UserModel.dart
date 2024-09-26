
class UserModel {
  String? fullName;
  String? email;
  String? phone;
  dynamic profilePhoto;
  dynamic resetPasswordToken;
  dynamic resetPasswordExpires;
  String? id;
  int? v;

  UserModel({this.fullName, this.email, this.phone, this.profilePhoto, this.resetPasswordToken, this.resetPasswordExpires, this.id, this.v});

  UserModel.fromJson(Map<String, dynamic> json) {
    if(json["fullName"] is String) {
      fullName = json["fullName"];
    }
    if(json["email"] is String) {
      email = json["email"];
    }
    if(json["phone"] is String) {
      phone = json["phone"];
    }
    profilePhoto = json["profilePhoto"];
    resetPasswordToken = json["resetPasswordToken"];
    resetPasswordExpires = json["resetPasswordExpires"];
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["__v"] is num) {
      v = (json["__v"] as num).toInt();
    }
  }

  static List<UserModel> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => UserModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["fullName"] = fullName;
    _data["email"] = email;
    _data["phone"] = phone;
    _data["profilePhoto"] = profilePhoto;
    _data["resetPasswordToken"] = resetPasswordToken;
    _data["resetPasswordExpires"] = resetPasswordExpires;
    _data["_id"] = id;
    _data["__v"] = v;
    return _data;
  }

  UserModel copyWith({
    String? fullName,
    String? email,
    String? phone,
    dynamic profilePhoto,
    dynamic resetPasswordToken,
    dynamic resetPasswordExpires,
    String? id,
    int? v,
  }) => UserModel(
    fullName: fullName ?? this.fullName,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    profilePhoto: profilePhoto ?? this.profilePhoto,
    resetPasswordToken: resetPasswordToken ?? this.resetPasswordToken,
    resetPasswordExpires: resetPasswordExpires ?? this.resetPasswordExpires,
    id: id ?? this.id,
    v: v ?? this.v,
  );
}