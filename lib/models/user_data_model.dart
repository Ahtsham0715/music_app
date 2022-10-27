class UserDataModel {
  UserDataModel({
    required this.success,
    required this.data,
    required this.message,
  });
  late final bool success;
  late final Data data;
  late final String message;

  UserDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = Data.fromJson(json['data']);
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.toJson();
    _data['message'] = message;
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    this.emailVerifiedAt,
    required this.password,
    required this.dpassword,
    required this.mobile,
    required this.country,
    this.rememberToken,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String name;
  late final String email;
  late final String username;
  late final Null emailVerifiedAt;
  late final String password;
  late final String dpassword;
  late final String mobile;
  late final String country;
  late final Null rememberToken;
  late final String createdAt;
  late final String updatedAt;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    emailVerifiedAt = null;
    password = json['password'];
    dpassword = json['dpassword'];
    mobile = json['mobile'];
    country = json['country'];
    rememberToken = null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    _data['username'] = username;
    _data['email_verified_at'] = emailVerifiedAt;
    _data['password'] = password;
    _data['dpassword'] = dpassword;
    _data['mobile'] = mobile;
    _data['country'] = country;
    _data['remember_token'] = rememberToken;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}
