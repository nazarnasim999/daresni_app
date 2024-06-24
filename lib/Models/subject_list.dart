import 'dart:convert';

SubjectList subjectListFromJson(String str) => SubjectList.fromJson(json.decode(str));

class SubjectList {
  int? code;
  bool? status;
  List<Subjects> subjects;

  SubjectList({
    this.code,
    this.status,
    this.subjects = const [],
  });

  factory SubjectList.fromJson(Map<String, dynamic> json) => SubjectList(
        code: json["code"],
        status: json["status"],
        subjects: json["data"] != null
            ? List<Subjects>.from(json["data"].map((x) => Subjects.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": List<dynamic>.from(subjects.map((x) => x.toJson())),
      };
}

class Subjects {
  int? id;
  String? nameInEnglish;
  String? nameInArabic;
  List<SubjectChild> subjectChild;
  bool selected;
  bool expand;

  Subjects({
    this.id,
    this.nameInEnglish,
    this.nameInArabic,
    this.subjectChild = const [],
    this.selected = false,
    this.expand = false,
  });

  factory Subjects.fromJson(Map<String, dynamic> json) => Subjects(
        id: json["id"],
        nameInEnglish: json["NameInEnglish"],
        selected: json["selected"] ?? false,
        expand: json["expand"] ?? false,
        nameInArabic: json["NameInArabic"],
        subjectChild: json["child"] != null
            ? List<SubjectChild>.from(json["child"].map((x) => SubjectChild.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "NameInEnglish": nameInEnglish,
        "NameInArabic": nameInArabic,
        "child": List<dynamic>.from(subjectChild.map((x) => x.toJson())),
      };
}

class SubjectChild {
  int? id;
  Name? name;
  List<SubChild> subChild;
  bool selected;
  bool expand;

  SubjectChild({
    this.id,
    this.name,
    this.subChild = const [],
    this.selected = false,
    this.expand = false,
  });

  factory SubjectChild.fromJson(Map<String, dynamic> json) => SubjectChild(
        id: json["id"],
        selected: json["selected"] ?? false,
        expand: json["expand"] ?? false,
        name: json["name"] != null ? Name.fromJson(json["name"]) : null,
        subChild: json["child"] != null
            ? List<SubChild>.from(json["child"].map((x) => SubChild.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name?.toJson(),
        "child": List<dynamic>.from(subChild.map((x) => x.toJson())),
      };
}

class SubChild {
  int? id;
  Name? name;
  bool selected;

  SubChild({
    this.id,
    this.name,
    this.selected = false,
  });

  factory SubChild.fromJson(Map<String, dynamic> json) => SubChild(
        id: json["id"],
        selected: json["selected"] ?? false,
        name: Name.fromJson(json["name"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name?.toJson(),
      };
}

class Name {
  String? en;
  String? ar;

  Name({
    this.en,
    this.ar,
  });

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        en: json["en"],
        ar: json["ar"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
        "ar": ar,
      };
}
