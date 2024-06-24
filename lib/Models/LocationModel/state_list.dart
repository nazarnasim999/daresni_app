import 'dart:convert';

StateList stateListFromJson(String str) => StateList.fromJson(json.decode(str));

class StateList {
  int? code;
  bool? status;
  List<States> state;

  StateList({
    this.code,
    this.status,
    this.state = const [],
  });

  factory StateList.fromJson(Map<String, dynamic> json) => StateList(
        code: json["code"],
        status: json["status"],
        state: json["data"] != null
            ? List<States>.from(json["data"].map((x) => States.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": List<dynamic>.from(state.map((x) => x.toJson())),
      };
}

class States {
  int? id;
  String name;

  States({
    this.id,
    this.name = '',
  });

  factory States.fromJson(Map<String, dynamic> json) => States(
        id: json["id"],
        name: json["name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
