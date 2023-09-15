class RankingModel {
  Poll? poll;
  num? season;
  num? week;
  String? effectiveTime;
  List<Rankings>? rankings;
  List<Candidates>? candidates;

  RankingModel(
      {this.poll,
      this.season,
      this.week,
      this.effectiveTime,
      this.rankings,
      this.candidates});

  RankingModel.fromJson(Map<String, dynamic> json) {
    poll = json['poll'] != null ? new Poll.fromJson(json['poll']) : null;
    season = json['season'];
    week = json['week'];
    effectiveTime = json['effective_time'];
    if (json['rankings'] != null) {
      rankings = <Rankings>[];
      json['rankings'].forEach((v) {
        rankings!.add(new Rankings.fromJson(v));
      });
    }
    if (json['candidates'] != null) {
      candidates = <Candidates>[];
      json['candidates'].forEach((v) {
        candidates!.add(new Candidates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.poll != null) {
      data['poll'] = this.poll!.toJson();
    }
    data['season'] = this.season;
    data['week'] = this.week;
    data['effective_time'] = this.effectiveTime;
    if (this.rankings != null) {
      data['rankings'] = this.rankings!.map((v) => v.toJson()).toList();
    }
    if (this.candidates != null) {
      data['candidates'] = this.candidates!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['alias'] = this.alias;
    data['name'] = this.name;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['market'] = this.market;
    data['rank'] = this.rank;
    data['wins'] = this.wins;
    data['losses'] = this.losses;
    data['ties'] = this.ties;
    data['prev_rank'] = this.prevRank;
    data['points'] = this.points;
    data['fp_votes'] = this.fpVotes;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['market'] = this.market;
    data['wins'] = this.wins;
    data['losses'] = this.losses;
    data['ties'] = this.ties;
    data['prev_rank'] = this.prevRank;
    data['votes'] = this.votes;
    return data;
  }
}
