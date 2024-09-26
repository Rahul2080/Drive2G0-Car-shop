
class LoginModel {
  String? token;
  String? id;
  String? fullName;
  String? email;
  String? phone;
  int? v;
  String? profilePhoto;
  String? resetPasswordExpires;
  String? resetPasswordToken;
  String? fcmToken;

  LoginModel({this.token, this.id, this.fullName, this.email, this.phone, this.v, this.profilePhoto, this.resetPasswordExpires, this.resetPasswordToken, this.fcmToken});

  LoginModel.fromJson(Map<String, dynamic> json) {
    if(json["token"] is String) {
      token = json["token"];
    }
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["fullName"] is String) {
      fullName = json["fullName"];
    }
    if(json["email"] is String) {
      email = json["email"];
    }
    if(json["phone"] is String) {
      phone = json["phone"];
    }
    if(json["__v"] is num) {
      v = (json["__v"] as num).toInt();
    }
    if(json["profilePhoto"] is String) {
      profilePhoto = json["profilePhoto"];
    }
    if(json["resetPasswordExpires"] is String) {
      resetPasswordExpires = json["resetPasswordExpires"];
    }
    if(json["resetPasswordToken"] is String) {
      resetPasswordToken = json["resetPasswordToken"];
    }
    if(json["fcmToken"] is String) {
      fcmToken = json["fcmToken"];
    }
  }

  static List<LoginModel> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => LoginModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["token"] = token;
    _data["_id"] = id;
    _data["fullName"] = fullName;
    _data["email"] = email;
    _data["phone"] = phone;
    _data["__v"] = v;
    _data["profilePhoto"] = profilePhoto;
    _data["resetPasswordExpires"] = resetPasswordExpires;
    _data["resetPasswordToken"] = resetPasswordToken;
    _data["fcmToken"] = fcmToken;
    return _data;
  }

  LoginModel copyWith({
    String? token,
    String? id,
    String? fullName,
    String? email,
    String? phone,
    int? v,
    String? profilePhoto,
    String? resetPasswordExpires,
    String? resetPasswordToken,
    String? fcmToken,
  }) => LoginModel(
    token: token ?? this.token,
    id: id ?? this.id,
    fullName: fullName ?? this.fullName,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    v: v ?? this.v,
    profilePhoto: profilePhoto ?? this.profilePhoto,
    resetPasswordExpires: resetPasswordExpires ?? this.resetPasswordExpires,
    resetPasswordToken: resetPasswordToken ?? this.resetPasswordToken,
    fcmToken: fcmToken ?? this.fcmToken,
  );
}