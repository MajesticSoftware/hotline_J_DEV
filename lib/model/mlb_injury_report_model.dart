class MLBInjuryReportModel {
  String? status;
  String? team;
  String? injuryStatus;
  String? fanDuelName;
  String? firstName;

  MLBInjuryReportModel({
    this.status,
    this.team,
    this.injuryStatus,
    this.fanDuelName,
    this.firstName,
  });

  MLBInjuryReportModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'] ?? '';
    team = json['Team'] ?? "";
    injuryStatus = json['InjuryStatus'] ?? "";
    fanDuelName = json['FanDuelName'] ?? "";
    firstName = json['FirstName'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    data['Team'] = team;
    data['InjuryStatus'] = injuryStatus;
    data['FanDuelName'] = fanDuelName;
    data['FirstName'] = firstName;
    return data;
  }
}
