import 'dart:convert';

import 'package:darasni/Models/LocationModel/state_list.dart';

MultiStatesModel multiStatesFromJson(String str) => MultiStatesModel.fromJson(json.decode(str));

class MultiStatesModel {
  bool status;
  String message;
  List<MultiStateList>? data;

  MultiStatesModel({
    this.status = false,
    this.message = "",
    this.data,
  });

  factory MultiStatesModel.fromJson(Map<String, dynamic> json) => MultiStatesModel(
        status: json["status"],
        message: json["message"],
        data: List<MultiStateList>.from(json["data"].map((x) => MultiStateList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MultiStateList {
  int? id;
  String? country;
  List<States>? states;

  MultiStateList({
    this.id,
    this.country,
    this.states,
  });

  factory MultiStateList.fromJson(Map<String, dynamic> json) => MultiStateList(
        id: json["id"],
        country: json["country"],
        states: List<States>.from(json["states"].map((x) => States.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country": country,
        "states": List<dynamic>.from(states!.map((x) => x.toJson())),
      };
}
