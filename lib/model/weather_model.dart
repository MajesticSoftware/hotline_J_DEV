class WeatherDataModel {
  List<Weather>? weather;
  Main? main;

  WeatherDataModel({
    this.weather,
    this.main,
  });

  WeatherDataModel.fromJson(Map<String, dynamic> json) {
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add(Weather.fromJson(v));
      });
    }

    main = json['main'] != null ? Main.fromJson(json['main']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (weather != null) {
      data['weather'] = weather!.map((v) => v.toJson()).toList();
    }

    if (main != null) {
      data['main'] = main!.toJson();
    }

    return data;
  }
}

class Weather {
  int? id;

  Weather({this.id});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}

class Main {
  num? temp;

  Main({this.temp});

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['temp'] = temp;
    return data;
  }
}
