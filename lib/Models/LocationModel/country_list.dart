import 'dart:convert';

CountryListModel countryListFromJson(String str) => CountryListModel.fromJson(json.decode(str));

class CountryListModel {
  int? code;
  bool? status;
  List<Countries>? countries;

  CountryListModel({
    this.code,
    this.status,
    this.countries,
  });

  factory CountryListModel.fromJson(Map<String, dynamic> json) => CountryListModel(
        code: json["code"],
        status: json["status"],
        countries: json["data"] != null
            ? List<Countries>.from(json["data"].map((x) => Countries.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": countries != null ? List<dynamic>.from(countries!.map((x) => x.toJson())) : null,
      };
}

class Countries {
  int? id;
  String? name;

  Countries({
    this.id,
    this.name,
  });

  factory Countries.fromJson(Map<String, dynamic> json) => Countries(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
