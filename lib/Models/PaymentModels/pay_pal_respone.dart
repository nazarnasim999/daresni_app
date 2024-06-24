import 'dart:convert';

PaypalResponse paypalResponseFromJson(String str) => PaypalResponse.fromJson(json.decode(str));

class PaypalResponse {
  String? payerId;
  String? paymentId;
  String? token;
  String? status;
  Data? data;

  PaypalResponse({
    this.payerId,
    this.paymentId,
    this.token,
    this.status,
    this.data,
  });

  factory PaypalResponse.fromJson(Map<String, dynamic> json) => PaypalResponse(
        payerId: json["payerID"],
        paymentId: json["paymentId"],
        token: json["token"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "payerID": payerId,
        "paymentId": paymentId,
        "token": token,
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  String? id;
  String? intent;
  String? state;
  String? cart;
  Payer? payer;
  List<Transaction>? transactions;
  List<dynamic>? failedTransactions;
  DateTime? createTime;
  DateTime? updateTime;
  List<Link>? links;

  Data({
    this.id,
    this.intent,
    this.state,
    this.cart,
    this.payer,
    this.transactions,
    this.failedTransactions,
    this.createTime,
    this.updateTime,
    this.links,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        intent: json["intent"],
        state: json["state"],
        cart: json["cart"],
        payer: json["payer"] != null ? Payer.fromJson(json["payer"]) : null,
        transactions: json["transactions"] != null
            ? List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x)))
            : null,
        failedTransactions: json["failed_transactions"] != null
            ? List<dynamic>.from(json["failed_transactions"].map((x) => x))
            : null,
        createTime: json["create_time"] != null ? DateTime.parse(json["create_time"]) : null,
        updateTime: json["update_time"] != null ? DateTime.parse(json["update_time"]) : null,
        links: json["links"] != null
            ? List<Link>.from(json["links"].map((x) => Link.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "intent": intent,
        "state": state,
        "cart": cart,
        "payer": payer?.toJson(),
        "transactions": List<dynamic>.from(transactions!.map((x) => x.toJson())),
        "failed_transactions": List<dynamic>.from(failedTransactions!.map((x) => x)),
        "create_time": createTime?.toIso8601String(),
        "update_time": updateTime?.toIso8601String(),
        "links": List<dynamic>.from(links!.map((x) => x.toJson())),
      };
}

class Link {
  String? href;
  String? rel;
  String? method;

  Link({
    this.href,
    this.rel,
    this.method,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        href: json["href"],
        rel: json["rel"],
        method: json["method"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
        "rel": rel,
        "method": method,
      };
}

class Payer {
  String? paymentMethod;
  String? status;
  PayerInfo? payerInfo;

  Payer({
    this.paymentMethod,
    this.status,
    this.payerInfo,
  });

  factory Payer.fromJson(Map<String, dynamic> json) => Payer(
        paymentMethod: json["payment_method"],
        status: json["status"],
        payerInfo: json["payer_info"] != null ? PayerInfo.fromJson(json["payer_info"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "payment_method": paymentMethod,
        "status": status,
        "payer_info": payerInfo?.toJson(),
      };
}

class PayerInfo {
  String? email;
  String? firstName;
  String? lastName;
  String? payerId;
  ShippingAddress? shippingAddress;
  String? countryCode;

  PayerInfo({
    this.email,
    this.firstName,
    this.lastName,
    this.payerId,
    this.shippingAddress,
    this.countryCode,
  });

  factory PayerInfo.fromJson(Map<String, dynamic> json) => PayerInfo(
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        payerId: json["payer_id"],
        shippingAddress: json["shipping_address"] != null
            ? ShippingAddress.fromJson(json["shipping_address"])
            : null,
        countryCode: json["country_code"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "payer_id": payerId,
        "shipping_address": shippingAddress?.toJson(),
        "country_code": countryCode,
      };
}

class ShippingAddress {
  String? recipientName;
  String? line1;
  String? city;
  String? state;
  String? postalCode;
  String? countryCode;

  ShippingAddress({
    this.recipientName,
    this.line1,
    this.city,
    this.state,
    this.postalCode,
    this.countryCode,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) => ShippingAddress(
        recipientName: json["recipient_name"],
        line1: json["line1"],
        city: json["city"],
        state: json["state"],
        postalCode: json["postal_code"],
        countryCode: json["country_code"],
      );

  Map<String, dynamic> toJson() => {
        "recipient_name": recipientName,
        "line1": line1,
        "city": city,
        "state": state,
        "postal_code": postalCode,
        "country_code": countryCode,
      };
}

class Transaction {
  TransactionAmount? amount;

  Transaction({
    this.amount,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        amount: json["amount"] != null ? TransactionAmount.fromJson(json["amount"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "amount": amount?.toJson(),
      };
}

class TransactionAmount {
  String? total;
  String? currency;
  Details? details;
  Payee? payee;
  String? description;
  ItemList? itemList;
  List<RelatedResource>? relatedResources;

  TransactionAmount({
    this.total,
    this.currency,
    this.details,
    this.payee,
    this.description,
    this.itemList,
    this.relatedResources,
  });

  factory TransactionAmount.fromJson(Map<String, dynamic> json) => TransactionAmount(
        total: json["total"],
        currency: json["currency"],
        details: json["details"] != null ? Details.fromJson(json["details"]) : null,
        payee: json["payee"] != null ? Payee.fromJson(json["payee"]) : null,
        description: json["description"],
        itemList: json["item_list"] != null ? ItemList.fromJson(json["item_list"]) : null,
        relatedResources: json["related_resources"] != null
            ? List<RelatedResource>.from(
                json["related_resources"].map((x) => RelatedResource.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "currency": currency,
        "details": details?.toJson(),
        "payee": payee?.toJson(),
        "description": description,
        "item_list": itemList?.toJson(),
        "related_resources": List<dynamic>.from(relatedResources!.map((x) => x.toJson())),
      };
}

class Details {
  String? subtotal;
  String? shipping;

  Details({
    this.subtotal,
    this.shipping,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        subtotal: json["subtotal"],
        shipping: json["shipping"],
      );

  Map<String, dynamic> toJson() => {
        "subtotal": subtotal,
        "shipping": shipping,
      };
}

class ItemList {
  List<Item>? items;
  ShippingAddress? shippingAddress;

  ItemList({
    this.items,
    this.shippingAddress,
  });

  factory ItemList.fromJson(Map<String, dynamic> json) => ItemList(
        items: json["items"] != null
            ? List<Item>.from(json["items"].map((x) => Item.fromJson(x)))
            : null,
        shippingAddress: json["shipping_address"] != null
            ? ShippingAddress.fromJson(json["shipping_address"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
        "shipping_address": shippingAddress?.toJson(),
      };
}

class Item {
  String? name;
  String? price;
  String? currency;
  String? tax;
  int? quantity;
  String? imageUrl;

  Item({
    this.name,
    this.price,
    this.currency,
    this.tax,
    this.quantity,
    this.imageUrl,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        name: json["name"],
        price: json["price"],
        currency: json["currency"],
        tax: json["tax"],
        quantity: json["quantity"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "currency": currency,
        "tax": tax,
        "quantity": quantity,
        "image_url": imageUrl,
      };
}

class Payee {
  String? merchantId;
  String? email;

  Payee({
    this.merchantId,
    this.email,
  });

  factory Payee.fromJson(Map<String, dynamic> json) => Payee(
        merchantId: json["merchant_id"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "merchant_id": merchantId,
        "email": email,
      };
}

class RelatedResource {
  Sale? sale;

  RelatedResource({
    this.sale,
  });

  factory RelatedResource.fromJson(Map<String, dynamic> json) => RelatedResource(
        sale: json["sale"] != null ? Sale.fromJson(json["sale"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "sale": sale?.toJson(),
      };
}

class Sale {
  String? id;
  String? state;
  SaleAmount? amount;
  String? paymentMode;
  String? protectionEligibility;
  String? protectionEligibilityType;
  TransactionFee? transactionFee;
  String? parentPayment;
  DateTime? createTime;
  DateTime? updateTime;
  List<Link>? links;

  Sale({
    this.id,
    this.state,
    this.amount,
    this.paymentMode,
    this.protectionEligibility,
    this.protectionEligibilityType,
    this.transactionFee,
    this.parentPayment,
    this.createTime,
    this.updateTime,
    this.links,
  });

  factory Sale.fromJson(Map<String, dynamic> json) => Sale(
        id: json["id"],
        state: json["state"],
        amount: json["amount"] != null ? SaleAmount.fromJson(json["amount"]) : null,
        paymentMode: json["payment_mode"],
        protectionEligibility: json["protection_eligibility"],
        protectionEligibilityType: json["protection_eligibility_type"],
        transactionFee: json["transaction_fee"]! + null
            ? TransactionFee.fromJson(json["transaction_fee"])
            : null,
        parentPayment: json["parent_payment"],
        createTime: json["create_time"] != null ? DateTime.parse(json["create_time"]) : null,
        updateTime: json["update_time"] != null ? DateTime.parse(json["update_time"]) : null,
        links: json["links"] != null
            ? List<Link>.from(json["links"].map((x) => Link.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "state": state,
        "amount": amount?.toJson(),
        "payment_mode": paymentMode,
        "protection_eligibility": protectionEligibility,
        "protection_eligibility_type": protectionEligibilityType,
        "transaction_fee": transactionFee?.toJson(),
        "parent_payment": parentPayment,
        "create_time": createTime?.toIso8601String(),
        "update_time": updateTime?.toIso8601String(),
        "links": List<dynamic>.from(links!.map((x) => x.toJson())),
      };
}

class SaleAmount {
  SaleAmount();

  factory SaleAmount.fromJson(Map<String, dynamic> json) => SaleAmount();

  Map<String, dynamic> toJson() => {};
}

class TransactionFee {
  String? value;
  String? currency;

  TransactionFee({
    this.value,
    this.currency,
  });

  factory TransactionFee.fromJson(Map<String, dynamic> json) => TransactionFee(
        value: json["value"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "currency": currency,
      };
}
