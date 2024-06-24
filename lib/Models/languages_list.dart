import 'dart:convert';

LanguagesList languagesListFromJson(String str) => LanguagesList.fromJson(json.decode(str));

class LanguagesList {
  int? code;
  bool? status;
  List<Languages> languages;

  LanguagesList({
    this.code,
    this.status,
    this.languages = const [],
  });

  factory LanguagesList.fromJson(Map<String, dynamic> json) => LanguagesList(
        code: json["code"],
        status: json["status"],
        languages: json["data"] != null
            ? List<Languages>.from(json["data"].map((x) => Languages.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": List<dynamic>.from(languages.map((x) => x.toJson())),
      };
}

class Languages {
  int? id;
  String nameInEnglish;
  String nameInArabic;

  Languages({
    this.id,
    this.nameInEnglish = '',
    this.nameInArabic = '',
  });

  factory Languages.fromJson(Map<String, dynamic> json) => Languages(
        id: json["id"],
        nameInEnglish: json["NameInEnglish"],
        nameInArabic: json["NameInArabic"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "NameInEnglish": nameInEnglish,
        "NameInArabic": nameInArabic,
      };
}
