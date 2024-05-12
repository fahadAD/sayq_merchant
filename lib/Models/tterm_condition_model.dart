class TermsConditionModel {
  bool? success;
  String? message;
  Data? data;

  TermsConditionModel({this.success, this.message, this.data});

  TermsConditionModel.fromJson(Map<String, dynamic> json) {
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
  TermsAndCondition? termsAndCondition;

  Data({this.termsAndCondition});

  Data.fromJson(Map<String, dynamic> json) {
    termsAndCondition = json['terms_and_condition'] != null
        ? new TermsAndCondition.fromJson(json['terms_and_condition'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.termsAndCondition != null) {
      data['terms_and_condition'] = this.termsAndCondition!.toJson();
    }
    return data;
  }
}

class TermsAndCondition {
  int? id;
  String? page;
  String? title;
  String? description;
  int? status;
  String? createdAt;
  String? updatedAt;

  TermsAndCondition(
      {this.id,
        this.page,
        this.title,
        this.description,
        this.status,
        this.createdAt,
        this.updatedAt});

  TermsAndCondition.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    page = json['page'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['page'] = this.page;
    data['title'] = this.title;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
