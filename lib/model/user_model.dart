class UserModel {
  UserData? data;
  String? msg;
  bool? status;

  UserModel({this.data, this.msg, this.status});

  UserModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
    msg = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['msg'] = msg;
    data['status'] = status;
    return data;
  }
}

class UserData {
  num? userId;
  String? userToken;
  String? authToken;
  String? userName;
  String? userEmail;
  String? userPassword;
  String? userProfilePic;
  String? appleSocialId;
  String? googleSocialId;
  String? favouriteSport;
  int? isLoggedOut;

  UserData(
      {this.userId,
      this.userToken,
      this.authToken,
      this.userName,
      this.userEmail,
      this.userPassword,
      this.userProfilePic,
      this.appleSocialId,
      this.googleSocialId,
      this.favouriteSport,
      this.isLoggedOut});

  UserData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userToken = json['user_token'];
    authToken = json['auth_token'];
    userName = json['user_name'];
    userEmail = json['user_email'];
    userPassword = json['user_password'];
    userProfilePic = json['user_profile_pic'];
    appleSocialId = json['apple_social_id'];
    googleSocialId = json['google_social_id'];
    favouriteSport = json['favourite_sport'];
    isLoggedOut = json['is_logged_out'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_token'] = userToken;
    data['auth_token'] = authToken;
    data['user_name'] = userName;
    data['user_email'] = userEmail;
    data['user_password'] = userPassword;
    data['user_profile_pic'] = userProfilePic;
    data['apple_social_id'] = appleSocialId;
    data['google_social_id'] = googleSocialId;
    data['favourite_sport'] = favouriteSport;
    data['is_logged_out'] = isLoggedOut;
    return data;
  }
}
