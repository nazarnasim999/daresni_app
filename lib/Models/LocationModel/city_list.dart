import 'dart:convert';

CityList cityListFromJson(String str) => CityList.fromJson(json.decode(str));

class CityList {
  int? code;
  bool? status;
  List<Cities> cities;

  CityList({
    this.code,
    this.status,
    this.cities = const [],
  });

  factory CityList.fromJson(Map<String, dynamic> json) => CityList(
        code: json["code"],
        status: json["status"],
        cities: json["data"] != null
            ? List<Cities>.from(json["data"].map((x) => Cities.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": List<dynamic>.from(cities.map((x) => x.toJson())),
      };
}

class Cities {
  int? id;
  String name;

  Cities({
    this.id,
    this.name = "",
  });

  factory Cities.fromJson(Map<String, dynamic> json) => Cities(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
