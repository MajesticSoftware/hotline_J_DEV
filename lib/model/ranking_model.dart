class RankingModel {
  Poll? poll;
  num? season;
  // num? week;
  String? effectiveTime;
  List<Rankings>? rankings;
  List<Candidates>? candidates;

  RankingModel(
      {this.poll,
      this.season,
      // this.week,
      this.effectiveTime,
      this.rankings,
      this.candidates});

  RankingModel.fromJson(Map<String, dynamic> json) {
    poll = json['poll'] != null ? Poll.fromJson(json['poll']) : null;
    season = json['season'];
    // week = json['week'];
    effectiveTime = json['effective_time'];
    if (json['rankings'] != null) {
      rankings = <Rankings>[];
      json['rankings'].forEach((v) {
        rankings!.add(Rankings.fromJson(v));
      });
    }
    if (json['candidates'] != null) {
      candidates = <Candidates>[];
      json['candidates'].forEach((v) {
        candidates!.add(Candidates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (poll != null) {
      data['poll'] = poll!.toJson();
    }
    data['season'] = season;
    // data['week'] = week;
    data['effective_time'] = effectiveTime;
    if (rankings != null) {
      data['rankings'] = rankings!.map((v) => v.toJson()).toList();
    }
    if (candidates != null) {
      data['candidates'] = candidates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Poll {
  String? id;
  String? alias;
  String? name;

  Poll({this.id, this.alias, this.name});

  Poll.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    alias = json['alias'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['alias'] = alias;
    data['name'] = name;
    return data;
  }
}

class Rankings {
  String? id;
  String? name;
  String? market;
  num? rank;
  num? wins;
  num? losses;
  num? ties;
  num? prevRank;
  num? points;
  num? fpVotes;

  Rankings(
      {this.id,
      this.name,
      this.market,
      this.rank,
      this.wins,
      this.losses,
      this.ties,
      this.prevRank,
      this.points,
      this.fpVotes});

  Rankings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    market = json['market'];
    rank = json['rank'];
    wins = json['wins'];
    losses = json['losses'];
    ties = json['ties'];
    prevRank = json['prev_rank'];
    points = json['points'];
    fpVotes = json['fp_votes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['market'] = market;
    data['rank'] = rank;
    data['wins'] = wins;
    data['losses'] = losses;
    data['ties'] = ties;
    data['prev_rank'] = prevRank;
    data['points'] = points;
    data['fp_votes'] = fpVotes;
    return data;
  }
}

class Candidates {
  String? id;
  String? name;
  String? market;
  num? wins;
  num? losses;
  num? ties;
  num? prevRank;
  num? votes;

  Candidates(
      {this.id,
      this.name,
      this.market,
      this.wins,
      this.losses,
      this.ties,
      this.prevRank,
      this.votes});

  Candidates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    market = json['market'];
    wins = json['wins'];
    losses = json['losses'];
    ties = json['ties'];
    prevRank = json['prev_rank'];
    votes = json['votes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['market'] = market;
    data['wins'] = wins;
    data['losses'] = losses;
    data['ties'] = ties;
    data['prev_rank'] = prevRank;
    data['votes'] = votes;
    return data;
  }
}
