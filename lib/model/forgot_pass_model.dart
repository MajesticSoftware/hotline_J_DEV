class ForgotPasswordResModel {
  ForgotPasswordResModel({
    required this.status,
    required this.msg,
  });

  late final bool status;
  late final String msg;

  ForgotPasswordResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['status'] = status;
    data['msg'] = msg;
    return data;
  }
}
