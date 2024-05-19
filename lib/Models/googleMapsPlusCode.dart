class GoogleMapsPlusCode {
  bool? success;
  String? message;
  Data? data;

  GoogleMapsPlusCode({this.success, this.message, this.data});

  GoogleMapsPlusCode.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  List<GoogleMapsPlusCodeList>? googleMapsPlusCodeList;

  Data({this.googleMapsPlusCodeList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['google_maps_plus_code_list'] != null) {
      googleMapsPlusCodeList = <GoogleMapsPlusCodeList>[];
      json['google_maps_plus_code_list'].forEach((v) {
        googleMapsPlusCodeList!.add(new GoogleMapsPlusCodeList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.googleMapsPlusCodeList != null) {
      data['google_maps_plus_code_list'] =
          this.googleMapsPlusCodeList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GoogleMapsPlusCodeList {
  int? id;
  String? blockName;
  int? blockNumber;
  String? googleMapsPlusCode;
  dynamic latitude;
  dynamic longitude;
  int? position;
  String? createdAt;
  String? updatedAt;

  GoogleMapsPlusCodeList(
      {this.id,
        this.blockName,
        this.blockNumber,
        this.googleMapsPlusCode,
        this.latitude,
        this.longitude,
        this.position,
        this.createdAt,
        this.updatedAt});

  GoogleMapsPlusCodeList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    blockName = json['block_name'];
    blockNumber = json['block_number'];
    googleMapsPlusCode = json['google_maps_plus_code'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    position = json['position'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['block_name'] = this.blockName;
    data['block_number'] = this.blockNumber;
    data['google_maps_plus_code'] = this.googleMapsPlusCode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['position'] = this.position;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
