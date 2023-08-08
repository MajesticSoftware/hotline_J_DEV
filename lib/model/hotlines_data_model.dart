class HotlinesDataModel {
  String? generatedAt;
  List<SportScheduleSportEventsPlayersProps>?
      sportScheduleSportEventsPlayersProps;

  HotlinesDataModel(
      {this.generatedAt, this.sportScheduleSportEventsPlayersProps});

  HotlinesDataModel.fromJson(Map<String, dynamic> json) {
    generatedAt = json['generated_at'];
    if (json['sport_schedule_sport_events_players_props'] != null) {
      sportScheduleSportEventsPlayersProps =
          <SportScheduleSportEventsPlayersProps>[];
      json['sport_schedule_sport_events_players_props'].forEach((v) {
        sportScheduleSportEventsPlayersProps!
            .add(new SportScheduleSportEventsPlayersProps.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['generated_at'] = this.generatedAt;
    if (this.sportScheduleSportEventsPlayersProps != null) {
      data['sport_schedule_sport_events_players_props'] = this
          .sportScheduleSportEventsPlayersProps!
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}

class SportScheduleSportEventsPlayersProps {
  SportEvent? sportEvent;
  List<PlayersProps>? playersProps;

  SportScheduleSportEventsPlayersProps({this.sportEvent, this.playersProps});

  SportScheduleSportEventsPlayersProps.fromJson(Map<String, dynamic> json) {
    sportEvent = json['sport_event'] != null
        ? new SportEvent.fromJson(json['sport_event'])
        : null;
    if (json['players_props'] != null) {
      playersProps = <PlayersProps>[];
      json['players_props'].forEach((v) {
        playersProps!.add(new PlayersProps.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sportEvent != null) {
      data['sport_event'] = this.sportEvent!.toJson();
    }
    if (this.playersProps != null) {
      data['players_props'] =
          this.playersProps!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SportEvent {
  String? id;
  String? startTime;
  bool? startTimeConfirmed;
  List<Competitors>? competitors;

  SportEvent(
      {this.id, this.startTime, this.startTimeConfirmed, this.competitors});

  SportEvent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startTime = json['start_time'];
    startTimeConfirmed = json['start_time_confirmed'];
    if (json['competitors'] != null) {
      competitors = <Competitors>[];
      json['competitors'].forEach((v) {
        competitors!.add(new Competitors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start_time'] = this.startTime;
    data['start_time_confirmed'] = this.startTimeConfirmed;
    if (this.competitors != null) {
      data['competitors'] = this.competitors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Competitors {
  String? id;
  String? name;
  String? country;
  String? countryCode;
  String? abbreviation;
  String? qualifier;
  int? rotationNumber;

  Competitors(
      {this.id,
      this.name,
      this.country,
      this.countryCode,
      this.abbreviation,
      this.qualifier,
      this.rotationNumber});

  Competitors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    country = json['country'];
    countryCode = json['country_code'];
    abbreviation = json['abbreviation'];
    qualifier = json['qualifier'];
    rotationNumber = json['rotation_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['country'] = this.country;
    data['country_code'] = this.countryCode;
    data['abbreviation'] = this.abbreviation;
    data['qualifier'] = this.qualifier;
    data['rotation_number'] = this.rotationNumber;
    return data;
  }
}

class PlayersProps {
  Player? player;
  List<Markets>? markets;

  PlayersProps({this.player, this.markets});

  PlayersProps.fromJson(Map<String, dynamic> json) {
    player =
        json['player'] != null ? new Player.fromJson(json['player']) : null;
    if (json['markets'] != null) {
      markets = <Markets>[];
      json['markets'].forEach((v) {
        markets!.add(new Markets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.player != null) {
      data['player'] = this.player!.toJson();
    }
    if (this.markets != null) {
      data['markets'] = this.markets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Player {
  String? id;
  String? name;
  String? competitorId;

  Player({this.id, this.name, this.competitorId});

  Player.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    competitorId = json['competitor_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['competitor_id'] = this.competitorId;
    return data;
  }
}

class Markets {
  String? id;
  String? name;
  bool? isLive;
  List<Books>? books;

  Markets({this.id, this.name, this.isLive, this.books});

  Markets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isLive = json['is_live'];
    if (json['books'] != null) {
      books = <Books>[];
      json['books'].forEach((v) {
        books!.add(new Books.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['is_live'] = this.isLive;
    if (this.books != null) {
      data['books'] = this.books!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Books {
  String? id;
  String? name;
  bool? removed;
  String? externalSportEventId;
  String? externalMarketId;
  List<Outcomes>? outcomes;

  Books(
      {this.id,
      this.name,
      this.removed,
      this.externalSportEventId,
      this.externalMarketId,
      this.outcomes});

  Books.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    removed = json['removed'];
    externalSportEventId = json['external_sport_event_id'];
    externalMarketId = json['external_market_id'];
    if (json['outcomes'] != null) {
      outcomes = <Outcomes>[];
      json['outcomes'].forEach((v) {
        outcomes!.add(new Outcomes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['removed'] = this.removed;
    data['external_sport_event_id'] = this.externalSportEventId;
    data['external_market_id'] = this.externalMarketId;
    if (this.outcomes != null) {
      data['outcomes'] = this.outcomes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Outcomes {
  String? id;
  String? type;
  String? oddsDecimal;
  String? oddsAmerican;
  String? oddsFraction;
  String? openOddsDecimal;
  String? openOddsAmerican;
  String? openOddsFraction;
  String? total;
  String? openTotal;
  String? externalOutcomeId;
  bool? removed;

  Outcomes(
      {this.id,
      this.type,
      this.oddsDecimal,
      this.oddsAmerican,
      this.oddsFraction,
      this.openOddsDecimal,
      this.openOddsAmerican,
      this.openOddsFraction,
      this.total,
      this.openTotal,
      this.externalOutcomeId,
      this.removed});

  Outcomes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    oddsDecimal = json['odds_decimal'];
    oddsAmerican = json['odds_american'];
    oddsFraction = json['odds_fraction'];
    openOddsDecimal = json['open_odds_decimal'];
    openOddsAmerican = json['open_odds_american'];
    openOddsFraction = json['open_odds_fraction'];
    total = json['total'];
    openTotal = json['open_total'];
    externalOutcomeId = json['external_outcome_id'];
    removed = json['removed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['odds_decimal'] = this.oddsDecimal;
    data['odds_american'] = this.oddsAmerican;
    data['odds_fraction'] = this.oddsFraction;
    data['open_odds_decimal'] = this.openOddsDecimal;
    data['open_odds_american'] = this.openOddsAmerican;
    data['open_odds_fraction'] = this.openOddsFraction;
    data['total'] = this.total;
    data['open_total'] = this.openTotal;
    data['external_outcome_id'] = this.externalOutcomeId;
    data['removed'] = this.removed;
    return data;
  }
}
