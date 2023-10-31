class ChangePassResModel {
  ChangePassResModel({
    required this.status,
    required this.newToken,
    required this.msg,
  });
  late final bool status;
  late final String newToken;
  late final String msg;

  ChangePassResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    newToken = json['new_token'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['new_token'] = newToken;
    data['msg'] = msg;
    return data;
  }
}
