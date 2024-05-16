import 'dart:convert';
import 'package:flutter/material.dart';
import '../Models/parcel_crate_model.dart';
import '../Models/shop_model.dart';
import '/services/api-list.dart';
import '/services/server.dart';
import '/services/user-service.dart';
import 'package:get/get.dart';

class ShopController extends GetxController {
  UserService userService = UserService();
  Server server = Server();
  bool loader = true;
  List<ShopsData> shopList = <ShopsData>[];

  List<GoogleMapsBlock> googleMapsBlockList = <GoogleMapsBlock>[];
  GoogleMapsBlock deliveryCategorysValue = GoogleMapsBlock();
  late dynamic googleMapsBlockIndex = 0;

  // List<ShopsData> googleMapsBlockList = <ShopsData>[];
  // ShopsData deliveryCategorysValue = ShopsData();
  // late dynamic googleMapsBlockIndex = 0;


  String deliveryCategoryID = '';
  String update_deliveryCategoryID = '';
  TextEditingController addressController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController addressUpdateController = TextEditingController();
  TextEditingController nameUpdateController = TextEditingController();
  TextEditingController phoneUpdateController = TextEditingController();




  @override
  void onInit() {
    getShop();
    crateParcel();
    super.onInit();
  }

  getShopList() async {
    loader = true;
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
    getShop();
  }






  getShop() {
    server.getRequest(endPoint: APIList.shopList).then((response) {
      if (response != null && response.statusCode == 200) {
        loader = false;
        final jsonResponse = json.decode(response.body);
        var shopData = ShopModel.fromJson(jsonResponse);
        shopList = <ShopsData>[];
        shopList.addAll(shopData.data!.shops!);

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


  crateParcel() {
    server.getRequest(endPoint: APIList.parcelCreate).then((response) {
      print("object=Fahad=${response.body}");
      if (response != null && response.statusCode == 200) {
        loader = false;
        final jsonResponse = json.decode(response.body);
        var data = ParcelCrateModel.fromJson(jsonResponse);
        googleMapsBlockList = <GoogleMapsBlock>[];
        googleMapsBlockList.add(GoogleMapsBlock(id: 0,blockName: "Select Block Number".tr,));
        googleMapsBlockList.addAll(data.data!.googleMapsBlock!);
        print("object=Fahad=${googleMapsBlockList}");
      } else {
        loader = false;
      }
    });
  }
  shopPost(status) {
    loader = true;
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
    Map body = {
      'name': nameController.text,
      'address': addressController.text,
      'contact_no': phoneController.text,
      'google_maps_plus_code': deliveryCategoryID,
      'status': status == 'Active' ? '1':'0',
    };
    String jsonBody = json.encode(body);
    print(jsonBody);
    server
        .postRequestWithToken(endPoint: APIList.shopPost, body: jsonBody)
        .then((response) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);

      if (response != null && response.statusCode == 200) {
        print("object${response.body}");
        final jsonResponse = json.decode(response.body);



        addressController.clear();
        nameController.clear();
        phoneController.clear();
        loader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });

        getShopList();
        Get.back();

        Get.rawSnackbar(
            message: "${jsonResponse['message']}",
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.TOP);
      } else if (response != null && response.statusCode == 422) {
        if (jsonResponse['data']['message']['name'] != null) {
          Get.rawSnackbar(message: jsonResponse['data']['message']['name'].toString());
        } else if (jsonResponse['data']['message']['contact_no'] != null) {
          Get.rawSnackbar(message: jsonResponse['data']['message']['contact_no'].toString(), backgroundColor: Colors.red,
              snackPosition: SnackPosition.TOP);
        } else if (jsonResponse['data']['message']['address'] != null) {
          Get.rawSnackbar(message: jsonResponse['data']['message']['address'].toString(), backgroundColor: Colors.red,
              snackPosition: SnackPosition.TOP);
        }
        loader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {
        loader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
        Get.rawSnackbar(message: 'Please enter valid input');
      }
    });
  }

  shopUpdate(id,status) {
    loader = true;
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
    Map body = {
      'name': nameUpdateController.text,
      'address': addressUpdateController.text,
      'contact_no': phoneUpdateController.text,
      'google_maps_plus_code': update_deliveryCategoryID,
      'status': status == 'Active' ? '1':'0',
    };
    String jsonBody = json.encode(body);
    print(jsonBody);
    server
        .putRequest(endPoint: APIList.shopUpdate!+id, body: jsonBody)
        .then((response) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        addressUpdateController.clear();
        nameUpdateController.clear();
        phoneUpdateController.clear();

        loader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
        getShopList();
        Get.back();
        Get.rawSnackbar(
            message: "${jsonResponse['message']}",
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.TOP);
      } else if (response != null && response.statusCode == 422) {
        if (jsonResponse['data']['message']['name'] != null) {
          Get.rawSnackbar(message: jsonResponse['data']['message']['name'].toString(),backgroundColor: Colors.red,
              snackPosition: SnackPosition.TOP);
        } else if (jsonResponse['data']['message']['contact_no'] != null) {
          Get.rawSnackbar(message: jsonResponse['data']['message']['contact_no'].toString(), backgroundColor: Colors.red,
              snackPosition: SnackPosition.TOP);
        } else if (jsonResponse['data']['message']['address'] != null) {
          Get.rawSnackbar(message: jsonResponse['data']['message']['address'].toString(), backgroundColor: Colors.red,
              snackPosition: SnackPosition.TOP);
        }
        loader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {
        loader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
        Get.rawSnackbar(message: 'Please enter valid input');
      }
    });
  }

  shopDelete(id) async {
    server
        .deleteRequest(endPoint: APIList.shopDelete!+id)
        .then((response) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        loader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
         getShopList();
        getShop();
        Get.back();
        Get.rawSnackbar(
            message: "${jsonResponse['message']}",
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.TOP);

      } else {
        loader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
        Get.rawSnackbar(message: 'Please enter valid input');
      }
    });
  }

}
