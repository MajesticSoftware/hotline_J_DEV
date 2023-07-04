// To parse this JSON data, do
//
//     final injuriesDataModel = injuriesDataModelFromJson(jsonString);

import 'dart:convert';

class InjuriesDataModel {
  int playerId;
  dynamic team;
  String name;
  String shortName;
  String collegeDraftTeam;

  InjuriesDataModel({
    required this.playerId,
    required this.team,
    required this.name,
    required this.shortName,
    required this.collegeDraftTeam,
  });

  InjuriesDataModel copyWith({
    int? playerId,
    dynamic team,
    String? name,
    String? shortName,
    String? collegeDraftTeam,
  }) =>
      InjuriesDataModel(
        playerId: playerId ?? this.playerId,
        team: team ?? this.team,
        name: name ?? this.name,
        shortName: shortName ?? this.shortName,
        collegeDraftTeam: collegeDraftTeam ?? this.collegeDraftTeam,
      );

  factory InjuriesDataModel.fromRawJson(String str) =>
      InjuriesDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InjuriesDataModel.fromJson(Map<String, dynamic> json) =>
      InjuriesDataModel(
        playerId: json["PlayerID"],
        team: json["Team"],
        name: json["Name"],
        shortName: json["ShortName"],
        collegeDraftTeam: json["CollegeDraftTeam"],
      );

  Map<String, dynamic> toJson() => {
        "PlayerID": playerId,
        "Team": team,
        "Name": name,
        "ShortName": shortName,
        "CollegeDraftTeam": collegeDraftTeam,
      };
}
