import 'dart:convert';
import '../Models/completed_delivery_model.dart';
import '/Models/balance_detials_model.dart';
import 'package:flutter/material.dart';

import '../Models/payment_account_list_model.dart';
import '../Models/support_list.dart';
import '/services/api-list.dart';
import '/services/server.dart';
import '/services/user-service.dart';
import 'package:get/get.dart';

class BalanceController extends GetxController {
  UserService userService = UserService();
  Server server = Server();
  bool loader = true;
  BalanceDetailsModel balanceDetails = BalanceDetailsModel();

  List<CompletedDelivery> parcelList = <CompletedDelivery>[];

  @override
  void onInit() {
    getBalanceDetails();
    getParcelCompletedDelivery();
    super.onInit();
  }

  getBalanceDetails() {
    server.getRequest(endPoint: APIList.balanceDetails).then((response) {
      if (response != null && response.statusCode == 200) {
        loader = false;
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);
        balanceDetails = BalanceDetailsModel.fromJson(jsonResponse);
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {
        loader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      }
    });
  }

  getParcelCompletedDelivery() {
    server.getRequest(endPoint: APIList.parcel_completed_delivery).then((response) {
      print("ff${json.decode(response.body)}");
      if (response != null && response.statusCode == 200) {
        loader = false;
        final jsonResponse = json.decode(response.body);
        var parcelData = CompletedDeliveryModel.fromJson(jsonResponse);
        parcelList = <CompletedDelivery>[];
        parcelList.addAll(parcelData.data!.parcels!);
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {
        loader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      }
    });
  }


}
