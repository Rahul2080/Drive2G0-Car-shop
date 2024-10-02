class SendMessageModel {
  SendMessageModel({
      this.user, 
      this.queryDescription,});

  SendMessageModel.fromJson(dynamic json) {
    user = json['user'];
    queryDescription = json['queryDescription'];
  }
  String? user;
  String? queryDescription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user'] = user;
    map['queryDescription'] = queryDescription;
    return map;
  }

}