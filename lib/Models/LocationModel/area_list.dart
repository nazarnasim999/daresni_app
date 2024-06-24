import 'dart:convert';

AreaList areaListFromJson(String str) => AreaList.fromJson(json.decode(str));

class AreaList {
  int? code;
  bool? status;
  List<Areas>? areas;

  AreaList({
    this.code,
    this.status,
    this.areas = const [],
  });

  factory AreaList.fromJson(Map<String, dynamic> json) => AreaList(
        code: json["code"],
        status: json["status"],
        areas: json["data"] != null
            ? List<Areas>.from(json["data"].map((x) => Areas.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": List<dynamic>.from(areas!.map((x) => x.toJson())),
      };
}

class Areas {
  int? id;
  String name;

  Areas({
    this.id,
    this.name = '',
  });

  factory Areas.fromJson(Map<String, dynamic> json) => Areas(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
