// class ShopModel {
//   ShopModel({
//       bool? success,
//       String? message,
//       DataShop? data,
//   }){
//     _success = success;
//     _message = message;
//     _data = data;
// }
//
//   ShopModel.fromJson(dynamic json) {
//     _success = json['success'];
//     _message = json['message'];
//     _data = json['data'] != null ? DataShop.fromJson(json['data']) : null;
//   }
//   bool? _success;
//   String? _message;
//   DataShop? _data;
//
//   bool? get success => _success;
//   String? get message => _message;
//   DataShop? get data => _data;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['success'] = _success;
//     map['message'] = _message;
//     if (_data != null) {
//       map['data'] = _data?.toJson();
//     }
//     return map;
//   }
//
// }
//
// class DataShop {
//   DataShop({
//       List<ShopsData>? shops,}){
//     _shops = shops;
// }
//
//   DataShop.fromJson(dynamic json) {
//     if (json['shops'] != null) {
//       _shops = [];
//       json['shops'].forEach((v) {
//         _shops?.add(ShopsData.fromJson(v));
//       });
//     }
//   }
//   List<ShopsData>? _shops;
//
//   List<ShopsData>? get shops => _shops;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (_shops != null) {
//       map['shops'] = _shops?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
//
// }
//
// class ShopsData {
//   ShopsData({
//       int? id,
//       String? merchantId,
//       String? name,
//       String? contactNo,
//       String? address,
//       String? defaultShop,
//       int? status,
//       String? statusName,
//       String? createdAt,
//       String? updatedAt,}){
//     _id = id;
//     _merchantId = merchantId;
//     _name = name;
//     _contactNo = contactNo;
//     _address = address;
//     _defaultShop = defaultShop;
//     _status = status;
//     _statusName = statusName;
//     _createdAt = createdAt;
//     _updatedAt = updatedAt;
// }
//
//   ShopsData.fromJson(dynamic json) {
//     _id = json['id'];
//     _merchantId = json['merchant_id'].toString();
//     _name = json['name'];
//     _contactNo = json['contact_no'];
//     _address = json['address'];
//     _defaultShop = json['default_shop'].toString();
//     _status = json['status'];
//     _statusName = json['statusName'];
//     _createdAt = json['created_at'];
//     _updatedAt = json['updated_at'];
//   }
//   int? _id;
//   String? _merchantId;
//   String? _name;
//   String? _contactNo;
//   String? _address;
//   String? _defaultShop;
//   int? _status;
//   String? _statusName;
//   String? _createdAt;
//   String? _updatedAt;
//
//   int? get id => _id;
//   String? get merchantId => _merchantId;
//   String? get name => _name;
//   String? get contactNo => _contactNo;
//   String? get address => _address;
//   String? get defaultShop => _defaultShop;
//   int? get status => _status;
//   String? get statusName => _statusName;
//   String? get createdAt => _createdAt;
//   String? get updatedAt => _updatedAt;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['merchant_id'] = _merchantId;
//     map['name'] = _name;
//     map['contact_no'] = _contactNo;
//     map['address'] = _address;
//     map['default_shop'] = _defaultShop;
//     map['status'] = _status;
//     map['statusName'] = _statusName;
//     map['created_at'] = _createdAt;
//     map['updated_at'] = _updatedAt;
//     return map;
//   }
//
// }

class ShopModel {
  bool? success;
  String? message;
  DataShop? data;

  ShopModel({this.success, this.message, this.data});

  ShopModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new DataShop.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataShop {
  List<ShopsData>? shops;

  DataShop({this.shops});

  DataShop.fromJson(Map<String, dynamic> json) {
    if (json['shops'] != null) {
      shops = <ShopsData>[];
      json['shops'].forEach((v) {
        shops!.add(new ShopsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shops != null) {
      data['shops'] = this.shops!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShopsData {
  int? id;
  int? merchantId;
  String? name;
  String? contactNo;
  String? address;
  String? merchantLat;
  String? merchantLong;
  String? googleMapsPlusCode;
  String? defaultShop;
  int? status;
  String? statusName;
  String? createdAt;
  String? updatedAt;

  ShopsData(
      {this.id,
        this.merchantId,
        this.name,
        this.contactNo,
        this.address,
        this.merchantLat,
        this.merchantLong,
        this.googleMapsPlusCode,
        this.defaultShop,
        this.status,
        this.statusName,
        this.createdAt,
        this.updatedAt});

  ShopsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    merchantId = json['merchant_id'];
    name = json['name'];
    contactNo = json['contact_no'];
    address = json['address'];
    merchantLat = json['merchant_lat'];
    merchantLong = json['merchant_long'];
    googleMapsPlusCode = json['google_maps_plus_code'];
    defaultShop = json['default_shop'];
    status = json['status'];
    statusName = json['statusName'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['merchant_id'] = this.merchantId;
    data['name'] = this.name;
    data['contact_no'] = this.contactNo;
    data['address'] = this.address;
    data['merchant_lat'] = this.merchantLat;
    data['merchant_long'] = this.merchantLong;
    data['google_maps_plus_code'] = this.googleMapsPlusCode;
    data['default_shop'] = this.defaultShop;
    data['status'] = this.status;
    data['statusName'] = this.statusName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
