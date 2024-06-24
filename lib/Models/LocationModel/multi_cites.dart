import 'dart:convert';

import 'package:darasni/Models/LocationModel/area_list.dart';

MultiCitesModel multiCitesFromJson(String str) => MultiCitesModel.fromJson(json.decode(str));

class MultiCitesModel {
  bool status;
  String message;
  List<MultiCitesList>? data;
  List<String>? errors;

  MultiCitesModel({
    this.status = false,
    this.message = "",
    this.data,
    this.errors,
  });

  factory MultiCitesModel.fromJson(Map<String, dynamic> json) => MultiCitesModel(
        status: json["status"],
        message: json["message"],
        data: List<MultiCitesList>.from(json["data"].map((x) => MultiCitesList.fromJson(x))),
        errors: List<String>.from(json["errors"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "errors": List<dynamic>.from(errors!.map((x) => x)),
      };
}

class MultiCitesList {
  int? id;
  String? state;
  List<Areas>? cities;

  MultiCitesList({
    this.id,
    this.state,
    this.cities,
  });

  factory MultiCitesList.fromJson(Map<String, dynamic> json) => MultiCitesList(
        id: json["id"],
        state: json["state"],
        cities: List<Areas>.from(json["cities"].map((x) => Areas.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "state": state,
        "cities": List<dynamic>.from(cities!.map((x) => x.toJson())),
      };
}

// class City {
//   int id;
//   String name;
//   int stateId;
//   int countryId;
//
//   City({
//     this.id,
//     this.name,
//     this.stateId,
//     this.countryId,
//   });
//
//   factory City.fromJson(Map<String, dynamic> json) => City(
//     id: json["id"],
//     name: json["name"],
//     stateId: json["state_id"],
//     countryId: json["country_id"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "state_id": stateId,
//     "country_id": countryId,
//   };
// }
//
