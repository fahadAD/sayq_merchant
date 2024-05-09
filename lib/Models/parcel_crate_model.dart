// To parse this JSON data, do
//
//     final parcelCrateModel = parcelCrateModelFromJson(jsonString);

import 'dart:convert';

ParcelCrateModel parcelCrateModelFromJson(String str) => ParcelCrateModel.fromJson(json.decode(str));

String parcelCrateModelToJson(ParcelCrateModel data) => json.encode(data.toJson());

class ParcelCrateModel {
  bool? success;
  String? message;
  Data? data;

  ParcelCrateModel({
    this.success,
    this.message,
    this.data,
  });

  factory ParcelCrateModel.fromJson(Map<String, dynamic> json) => ParcelCrateModel(
    success: json["success"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data!.toJson(),
  };
}

class Data {
  Merchant? merchant;
  List<Shop>? shops;
  List<DeliveryCategory>? deliveryCategories;
  List<DeliveryCharge>? deliveryCharges;
  List<CodCharge>? codCharges;
  List<Packaging>? packagings;
  String? fragileLiquid;
  List<DeliveryType>? deliveryTypes;

  Data({
    this.merchant,
    this.shops,
    this.deliveryCategories,
    this.deliveryCharges,
    this.codCharges,
    this.packagings,
    this.fragileLiquid,
    this.deliveryTypes,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    merchant: Merchant.fromJson(json["merchant"]),
    shops: List<Shop>.from(json["shops"].map((x) => Shop.fromJson(x))),
    deliveryCategories: List<DeliveryCategory>.from(json["deliveryCategories"].map((x) => DeliveryCategory.fromJson(x))),
    deliveryCharges: List<DeliveryCharge>.from(json["deliveryCharges"].map((x) => DeliveryCharge.fromJson(x))),
    codCharges: List<CodCharge>.from(json["codCharges"].map((x) => CodCharge.fromJson(x))),
    packagings: List<Packaging>.from(json["packagings"].map((x) => Packaging.fromJson(x))),
    fragileLiquid: json["fragileLiquid"],
    deliveryTypes: List<DeliveryType>.from(json["deliveryTypes"].map((x) => DeliveryType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "merchant": merchant!.toJson(),
    "shops": List<dynamic>.from(shops!.map((x) => x.toJson())),
    "deliveryCategories": List<dynamic>.from(deliveryCategories!.map((x) => x.toJson())),
    "deliveryCharges": List<dynamic>.from(deliveryCharges!.map((x) => x.toJson())),
    "codCharges": List<dynamic>.from(codCharges!.map((x) => x.toJson())),
    "packagings": List<dynamic>.from(packagings!.map((x) => x.toJson())),
    "fragileLiquid": fragileLiquid,
    "deliveryTypes": List<dynamic>.from(deliveryTypes!.map((x) => x.toJson())),
  };
}

class CodCharge {
  String? name;
  String? charge;

  CodCharge({
    this.name,
    this.charge,
  });

  factory CodCharge.fromJson(Map<String, dynamic> json) => CodCharge(
    name: json["name"],
    charge: json["charge"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "charge": charge,
  };
}

class DeliveryCategory {
  int? id;
  String? title;
  int? minimumKilometer;
  int? minimumKilometerRate;
  int? kilometerRate;
  int? status;
  int? position;
  DateTime? createdAt;
  DateTime? updatedAt;

  DeliveryCategory({
    this.id,
    this.title,
    this.minimumKilometer,
    this.minimumKilometerRate,
    this.kilometerRate,
    this.status,
    this.position,
    this.createdAt,
    this.updatedAt,
  });

  factory DeliveryCategory.fromJson(Map<String, dynamic> json) => DeliveryCategory(
    id: json["id"],
    title: json["title"],
    minimumKilometer: json["minimum_kilometer"],
    minimumKilometerRate: json["minimum_kilometer_rate"],
    kilometerRate: json["kilometer_rate"],
    status: json["status"],
    position: json["position"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "minimum_kilometer": minimumKilometer,
    "minimum_kilometer_rate": minimumKilometerRate,
    "kilometer_rate": kilometerRate,
    "status": status,
    "position": position,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

class DeliveryCharge {
  int? id;
  String? merchantId;
  String? categoryId;
  String? deliveryChargeId;
  Category? category;
  String? weight;
  String? sameDay;
  String? nextDay;
  String? subCity;
  String? outsideCity;
  String? status;
  StatusName? statusName;

  DeliveryCharge({
    this.id,
    this.merchantId,
    this.categoryId,
    this.deliveryChargeId,
    this.category,
    this.weight,
    this.sameDay,
    this.nextDay,
    this.subCity,
    this.outsideCity,
    this.status,
    this.statusName,
  });

  factory DeliveryCharge.fromJson(Map<String, dynamic> json) => DeliveryCharge(
    id: json["id"],
    merchantId: json["merchant_id"],
    categoryId: json["category_id"],
    deliveryChargeId: json["delivery_charge_id"],
    category: categoryValues.map[json["category"]],
    weight: json["weight"],
    sameDay: json["same_day"],
    nextDay: json["next_day"],
    subCity: json["sub_city"],
    outsideCity: json["outside_city"],
    status: json["status"],
    statusName: statusNameValues.map[json["statusName"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "merchant_id": merchantId,
    "category_id": categoryId,
    "delivery_charge_id": deliveryChargeId,
    "category": categoryValues.reverse[category],
    "weight": weight,
    "same_day": sameDay,
    "next_day": nextDay,
    "sub_city": subCity,
    "outside_city": outsideCity,
    "status": status,
    "statusName": statusNameValues.reverse[statusName],
  };
}

enum Category {
  CAR
}

final categoryValues = EnumValues({
  "Car": Category.CAR
});

enum StatusName {
  ACTIVE
}

final statusNameValues = EnumValues({
  "Active": StatusName.ACTIVE
});

class DeliveryType {
  int? id;
  String? key;
  String? value;
  DateTime? createdAt;
  DateTime? updatedAt;

  DeliveryType({
    this.id,
    this.key,
    this.value,
    this.createdAt,
    this.updatedAt,
  });

  factory DeliveryType.fromJson(Map<String, dynamic> json) => DeliveryType(
    id: json["id"],
    key: json["key"],
    value: json["value"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "key": key,
    "value": value,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

class Merchant {
  int? id;
  int? userId;
  String? businessName;
  String? merchantUniqueId;
  String? currentBalance;
  String? openingBalance;
  String? walletBalance;
  String? vat;
  CodCharges? codCharges;
  dynamic nidId;
  dynamic tradeLicense;
  String? paymentPeriod;
  int? status;
  String? address;
  int? walletUseActivation;
  String? returnCharges;
  dynamic referenceName;
  dynamic referencePhone;
  DateTime? createdAt;
  DateTime? updatedAt;

  Merchant({
    this.id,
    this.userId,
    this.businessName,
    this.merchantUniqueId,
    this.currentBalance,
    this.openingBalance,
    this.walletBalance,
    this.vat,
    this.codCharges,
    this.nidId,
    this.tradeLicense,
    this.paymentPeriod,
    this.status,
    this.address,
    this.walletUseActivation,
    this.returnCharges,
    this.referenceName,
    this.referencePhone,
    this.createdAt,
    this.updatedAt,
  });

  factory Merchant.fromJson(Map<String, dynamic> json) => Merchant(
    id: json["id"],
    userId: json["user_id"],
    businessName: json["business_name"],
    merchantUniqueId: json["merchant_unique_id"],
    currentBalance: json["current_balance"],
    openingBalance: json["opening_balance"],
    walletBalance: json["wallet_balance"],
    vat: json["vat"],
    codCharges: CodCharges.fromJson(json["cod_charges"]),
    nidId: json["nid_id"],
    tradeLicense: json["trade_license"],
    paymentPeriod: json["payment_period"],
    status: json["status"],
    address: json["address"],
    walletUseActivation: json["wallet_use_activation"],
    returnCharges: json["return_charges"],
    referenceName: json["reference_name"],
    referencePhone: json["reference_phone"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "business_name": businessName,
    "merchant_unique_id": merchantUniqueId,
    "current_balance": currentBalance,
    "opening_balance": openingBalance,
    "wallet_balance": walletBalance,
    "vat": vat,
    "cod_charges": codCharges!.toJson(),
    "nid_id": nidId,
    "trade_license": tradeLicense,
    "payment_period": paymentPeriod,
    "status": status,
    "address": address,
    "wallet_use_activation": walletUseActivation,
    "return_charges": returnCharges,
    "reference_name": referenceName,
    "reference_phone": referencePhone,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

class CodCharges {
  String? insideCity;
  String? subCity;
  String? outsideCity;

  CodCharges({
    this.insideCity,
    this.subCity,
    this.outsideCity,
  });

  factory CodCharges.fromJson(Map<String, dynamic> json) => CodCharges(
    insideCity: json["inside_city"],
    subCity: json["sub_city"],
    outsideCity: json["outside_city"],
  );

  Map<String, dynamic> toJson() => {
    "inside_city": insideCity,
    "sub_city": subCity,
    "outside_city": outsideCity,
  };
}

class Packaging {
  int? id;
  String? name;
  String? price;
  int? status;
  String? position;
  dynamic photo;
  DateTime? createdAt;
  DateTime? updatedAt;

  Packaging({
    this.id,
    this.name,
    this.price,
    this.status,
    this.position,
    this.photo,
    this.createdAt,
    this.updatedAt,
  });

  factory Packaging.fromJson(Map<String, dynamic> json) => Packaging(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    status: json["status"],
    position: json["position"],
    photo: json["photo"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "status": status,
    "position": position,
    "photo": photo,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

class Shop {
  int? id;
  int? merchantId;
  String? name;
  String? contactNo;
  String? address;
  dynamic merchantLat;
  dynamic merchantLong;
  int? status;
  int? defaultShop;
  DateTime? createdAt;
  DateTime? updatedAt;

  Shop({
    this.id,
    this.merchantId,
    this.name,
    this.contactNo,
    this.address,
    this.merchantLat,
    this.merchantLong,
    this.status,
    this.defaultShop,
    this.createdAt,
    this.updatedAt,
  });

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
    id: json["id"],
    merchantId: json["merchant_id"],
    name: json["name"],
    contactNo: json["contact_no"],
    address: json["address"],
    merchantLat: json["merchant_lat"],
    merchantLong: json["merchant_long"],
    status: json["status"],
    defaultShop: json["default_shop"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "merchant_id": merchantId,
    "name": name,
    "contact_no": contactNo,
    "address": address,
    "merchant_lat": merchantLat,
    "merchant_long": merchantLong,
    "status": status,
    "default_shop": defaultShop,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
