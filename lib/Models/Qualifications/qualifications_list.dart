import 'dart:convert';

QualificationList qualificationListFromJson(String str) =>
    QualificationList.fromJson(json.decode(str));

class QualificationList {
  int? code;
  bool? status;
  Data? data;

  QualificationList({
    this.code,
    this.status,
    this.data,
  });

  factory QualificationList.fromJson(Map<String, dynamic> json) => QualificationList(
        code: json["code"],
        status: json["status"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  int? currentPage;
  List<Qualification>? qualification;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Data({
    this.currentPage,
    this.qualification,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        qualification: json["data"] != null
            ? List<Qualification>.from(json["data"].map((x) => Qualification.fromJson(x)))
            : null,
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] != null
            ? List<Link>.from(json["links"].map((x) => Link.fromJson(x)))
            : null,
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(qualification!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Qualification {
  int? id;
  Name? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  Qualification({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Qualification.fromJson(Map<String, dynamic> json) => Qualification(
        id: json["id"],
        name: json["name"] != null ? Name.fromJson(json["name"]) : null,
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
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

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
