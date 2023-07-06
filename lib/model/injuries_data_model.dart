// To parse this JSON data, do
//
//     final injuriesDataModel = injuriesDataModelFromJson(jsonString);

import 'dart:convert';

class InjuriesDataModel {
  int playerId;
  dynamic team;
  String name;
  String shortName;
  String currentTeam;
  String currentStatus;

  InjuriesDataModel({
    required this.playerId,
    required this.team,
    required this.name,
    required this.shortName,
    required this.currentTeam,
    required this.currentStatus,
  });

  InjuriesDataModel copyWith({
    int? playerId,
    dynamic team,
    String? name,
    String? shortName,
    String? currentTeam,
    String? currentStatus,
  }) =>
      InjuriesDataModel(
        playerId: playerId ?? this.playerId,
        team: team ?? this.team,
        name: name ?? this.name,
        shortName: shortName ?? this.shortName,
        currentTeam: currentTeam ?? this.currentTeam,
        currentStatus: currentStatus ?? this.currentStatus,
      );

  factory InjuriesDataModel.fromRawJson(String str) =>
      InjuriesDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InjuriesDataModel.fromJson(Map<String, dynamic> json) =>
      InjuriesDataModel(
        playerId: json["PlayerID"] ?? 0,
        team: json["Team"] ?? "",
        name: json["Name"] ?? "",
        shortName: json["ShortName"] ?? "",
        currentTeam: json["CurrentTeam"] ?? "",
        currentStatus: json["CurrentStatus"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "PlayerID": playerId,
        "Team": team,
        "Name": name,
        "ShortName": shortName,
        "CurrentTeam": currentTeam,
        "CurrentStatus": currentStatus,
      };
}
