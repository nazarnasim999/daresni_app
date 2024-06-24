import 'dart:convert';

TapPaymentResponse tapPaymentResponseFromJson(String str) =>
    TapPaymentResponse.fromJson(json.decode(str));

class TapPaymentResponse {
  String? id;
  String? object;
  bool? liveMode;
  bool? customerInitiated;
  String? apiVersion;
  String? method;
  String? status;
  double? amount;
  String? currency;
  bool? threeDSecure;
  bool? cardThreeDSecure;
  bool? saveCard;
  String? merchantId;
  String? product;
  String? statementDescriptor;
  String? description;
  Metadata? metadata;
  Order? order;
  Transaction? transaction;
  Reference? reference;
  Response? response;
  Security? security;
  Acquirer? acquirer;
  Acquirer? gateway;
  Card? card;
  Receipt? receipt;
  Customer? customer;
  Merchant? merchant;
  Source? source;
  Post? redirect;
  Post? post;
  List<Activity>? activities;
  bool? autoReversed;
  String? message;

  TapPaymentResponse({
    this.id,
    this.object,
    this.liveMode,
    this.customerInitiated,
    this.apiVersion,
    this.method,
    this.status,
    this.amount,
    this.currency,
    this.threeDSecure,
    this.cardThreeDSecure,
    this.saveCard,
    this.merchantId,
    this.product,
    this.statementDescriptor,
    this.description,
    this.metadata,
    this.order,
    this.transaction,
    this.reference,
    this.response,
    this.security,
    this.acquirer,
    this.gateway,
    this.card,
    this.receipt,
    this.customer,
    this.merchant,
    this.source,
    this.redirect,
    this.post,
    this.activities,
    this.autoReversed,
    this.message,
  });

  factory TapPaymentResponse.fromJson(Map<String, dynamic> json) => TapPaymentResponse(
        id: json["id"],
        object: json["object"],
        liveMode: json["live_mode"],
        customerInitiated: json["customer_initiated"],
        apiVersion: json["api_version"],
        method: json["method"],
        status: json["status"],
        amount: json["amount"],
        currency: json["currency"],
        threeDSecure: json["threeDSecure"],
        cardThreeDSecure: json["card_threeDSecure"],
        saveCard: json["save_card"],
        merchantId: json["merchant_id"],
        product: json["product"],
        statementDescriptor: json["statement_descriptor"],
        description: json["description"],
        metadata: json["metadata"] != null ? Metadata.fromJson(json["metadata"]) : null,
        order: json["order"] != null ? Order.fromJson(json["order"]) : null,
        transaction: json["transaction"] != null ? Transaction.fromJson(json["transaction"]) : null,
        reference: json["reference"] != null ? Reference.fromJson(json["reference"]) : null,
        response: json["response"] != null ? Response.fromJson(json["response"]) : null,
        security: json["security"] != null ? Security.fromJson(json["security"]) : null,
        acquirer: json["acquirer"] != null ? Acquirer.fromJson(json["acquirer"]) : null,
        gateway: json["gateway"] != null ? Acquirer.fromJson(json["gateway"]) : null,
        card: json["card"] != null ? Card.fromJson(json["card"]) : null,
        receipt: json["receipt"] != null ? Receipt.fromJson(json["receipt"]) : null,
        customer: json["customer"] != null ? Customer.fromJson(json["customer"]) : null,
        merchant: json["merchant"] != null ? Merchant.fromJson(json["merchant"]) : null,
        source: json["source"] != null ? Source.fromJson(json["source"]) : null,
        redirect: json["redirect"] != null ? Post.fromJson(json["redirect"]) : null,
        post: json["post"] != null ? Post.fromJson(json["post"]) : null,
        activities: json["activities"] != null
            ? List<Activity>.from(json["activities"].map((x) => Activity.fromJson(x)))
            : null,
        autoReversed: json["auto_reversed"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "live_mode": liveMode,
        "customer_initiated": customerInitiated,
        "api_version": apiVersion,
        "method": method,
        "status": status,
        "amount": amount,
        "currency": currency,
        "threeDSecure": threeDSecure,
        "card_threeDSecure": cardThreeDSecure,
        "save_card": saveCard,
        "merchant_id": merchantId,
        "product": product,
        "statement_descriptor": statementDescriptor,
        "description": description,
        "metadata": metadata?.toJson(),
        "order": order?.toJson(),
        "transaction": transaction?.toJson(),
        "reference": reference?.toJson(),
        "response": response?.toJson(),
        "security": security?.toJson(),
        "acquirer": acquirer?.toJson(),
        "gateway": gateway?.toJson(),
        "card": card?.toJson(),
        "receipt": receipt?.toJson(),
        "customer": customer?.toJson(),
        "merchant": merchant?.toJson(),
        "source": source?.toJson(),
        "redirect": redirect?.toJson(),
        "post": post?.toJson(),
        "activities": List<dynamic>.from(activities!.map((x) => x.toJson())),
        "auto_reversed": autoReversed,
        "message": message,
      };
}

class Acquirer {
  Response? response;

  Acquirer({
    this.response,
  });

  factory Acquirer.fromJson(Map<String, dynamic> json) => Acquirer(
        response: json["response"] != null ? Response.fromJson(json["response"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "response": response?.toJson(),
      };
}

class Response {
  String? code;
  String? message;

  Response({
    this.code,
    this.message,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}

class Activity {
  String? id;
  String? object;
  int? created;
  String? status;
  String? currency;
  double? amount;
  String? remarks;

  Activity({
    this.id,
    this.object,
    this.created,
    this.status,
    this.currency,
    this.amount,
    this.remarks,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        id: json["id"],
        object: json["object"],
        created: json["created"],
        status: json["status"],
        currency: json["currency"],
        amount: json["amount"],
        remarks: json["remarks"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "created": created,
        "status": status,
        "currency": currency,
        "amount": amount,
        "remarks": remarks,
      };
}

class Card {
  String? object;
  String? firstSix;
  String? scheme;
  String? brand;
  String? lastFour;

  Card({
    this.object,
    this.firstSix,
    this.scheme,
    this.brand,
    this.lastFour,
  });

  factory Card.fromJson(Map<String, dynamic> json) => Card(
        object: json["object"],
        firstSix: json["first_six"],
        scheme: json["scheme"],
        brand: json["brand"],
        lastFour: json["last_four"],
      );

  Map<String, dynamic> toJson() => {
        "object": object,
        "first_six": firstSix,
        "scheme": scheme,
        "brand": brand,
        "last_four": lastFour,
      };
}

class Customer {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  Phone? phone;

  Customer({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"] != null ? Phone.fromJson(json["phone"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone?.toJson(),
      };
}

class Phone {
  String? countryCode;
  String? number;

  Phone({
    this.countryCode,
    this.number,
  });

  factory Phone.fromJson(Map<String, dynamic> json) => Phone(
        countryCode: json["country_code"],
        number: json["number"],
      );

  Map<String, dynamic> toJson() => {
        "country_code": countryCode,
        "number": number,
      };
}

class Merchant {
  String? country;
  String? currency;
  String? id;

  Merchant({
    this.country,
    this.currency,
    this.id,
  });

  factory Merchant.fromJson(Map<String, dynamic> json) => Merchant(
        country: json["country"],
        currency: json["currency"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "currency": currency,
        "id": id,
      };
}

class Metadata {
  String? udf1;
  String? udf2;

  Metadata({
    this.udf1,
    this.udf2,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        udf1: json["udf1"],
        udf2: json["udf2"],
      );

  Map<String, dynamic> toJson() => {
        "udf1": udf1,
        "udf2": udf2,
      };
}

class Order {
  String? id;

  Order({
    this.id,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class Post {
  String? status;
  String? url;

  Post({
    this.status,
    this.url,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        status: json["status"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "url": url,
      };
}

class Receipt {
  String? id;
  bool? email;
  bool? sms;

  Receipt({
    this.id,
    this.email,
    this.sms,
  });

  factory Receipt.fromJson(Map<String, dynamic> json) => Receipt(
        id: json["id"],
        email: json["email"],
        sms: json["sms"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "sms": sms,
      };
}

class Reference {
  String? track;
  String? payment;
  String? gateway;
  String? acquirer;
  String? transaction;
  String? order;

  Reference({
    this.track,
    this.payment,
    this.gateway,
    this.acquirer,
    this.transaction,
    this.order,
  });

  factory Reference.fromJson(Map<String, dynamic> json) => Reference(
        track: json["track"],
        payment: json["payment"],
        gateway: json["gateway"],
        acquirer: json["acquirer"],
        transaction: json["transaction"],
        order: json["order"],
      );

  Map<String, dynamic> toJson() => {
        "track": track,
        "payment": payment,
        "gateway": gateway,
        "acquirer": acquirer,
        "transaction": transaction,
        "order": order,
      };
}

class Security {
  ThreeDSecure? threeDSecure;

  Security({
    this.threeDSecure,
  });

  factory Security.fromJson(Map<String, dynamic> json) => Security(
        threeDSecure:
            json["threeDSecure"] != null ? ThreeDSecure.fromJson(json["threeDSecure"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "threeDSecure": threeDSecure!.toJson(),
      };
}

class ThreeDSecure {
  String? id;
  String? status;

  ThreeDSecure({
    this.id,
    this.status,
  });

  factory ThreeDSecure.fromJson(Map<String, dynamic> json) => ThreeDSecure(
        id: json["id"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
      };
}

class Source {
  String? object;
  String? type;
  String? paymentType;
  String? paymentMethod;
  String? channel;
  String? id;

  Source({
    this.object,
    this.type,
    this.paymentType,
    this.paymentMethod,
    this.channel,
    this.id,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        object: json["object"],
        type: json["type"],
        paymentType: json["payment_type"],
        paymentMethod: json["payment_method"],
        channel: json["channel"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "object": object,
        "type": type,
        "payment_type": paymentType,
        "payment_method": paymentMethod,
        "channel": channel,
        "id": id,
      };
}

class Transaction {
  String? authorizationId;
  String? timezone;
  String? created;
  Expiry? expiry;
  bool? asynchronous;
  double? amount;
  String? currency;

  Transaction({
    this.authorizationId,
    this.timezone,
    this.created,
    this.expiry,
    this.asynchronous,
    this.amount,
    this.currency,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        authorizationId: json["authorization_id"],
        timezone: json["timezone"],
        created: json["created"],
        expiry: json["expiry"] != null ? Expiry.fromJson(json["expiry"]) : null,
        asynchronous: json["asynchronous"],
        amount: json["amount"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "authorization_id": authorizationId,
        "timezone": timezone,
        "created": created,
        "expiry": expiry?.toJson(),
        "asynchronous": asynchronous,
        "amount": amount,
        "currency": currency,
      };
}

class Expiry {
  int? period;
  String? type;

  Expiry({
    this.period,
    this.type,
  });

  factory Expiry.fromJson(Map<String, dynamic> json) => Expiry(
        period: json["period"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "period": period,
        "type": type,
      };
}
