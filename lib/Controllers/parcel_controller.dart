import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nb_utils/nb_utils.dart';
import '../Models/edit_parcel_model.dart';
import '../Models/parcel_crate_model.dart';
import '../Models/parcel_logs_model.dart';
import '../Models/parcels_model.dart';
import '../Models/shop_model.dart';
import '../Screen/Widgets/button_global.dart';
import '../Screen/Widgets/constant.dart';
import '/services/api-list.dart';
import '/services/server.dart';
import '/services/user-service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;

import 'global-controller.dart';
class ParcelController extends GetxController {
  UserService userService = UserService();
  Server server = Server();
  bool loader = true;
  bool loaderParcel = false;
  bool loaderLogs = true;
  List<Parcels> parcelList = <Parcels>[];
  List<Shop> shopList = <Shop>[];
  List<Packaging> packagingList = <Packaging>[];
  List<DeliveryCharge> deliveryChargesList = <DeliveryCharge>[];
  List<DeliveryCategory> deliveryCategoryList = <DeliveryCategory>[];

  late double fragileLiquidAmount = 0;
  late int shopIndex = 0;
  late int packagingIndex = 0;
  late int deliveryChargesIndex = 0;
  late int deliveryCategoryIndex = 0;
  Merchant merchantData = Merchant();
  DeliveryCharges deliveryChargesValue = DeliveryCharges();
  DeliveryCategory deliveryCategorysValue = DeliveryCategory();
  String pickupPhone = '';
  String pickupAddress = '';
  String customerAddress = '';
  String shopID = '';
  String packagingID = '';
  String packagingPrice = '0';
  String deliveryChargesID = '';
  String deliveryCategoryID = '';
  String deliveryTypID = 'Same Day';
  String deliveryChargesPrice = '0';
  bool isLiquidChecked = false;
  bool isParcelBankCheck = false;
  double vatTax = 0;
  double vatAmount = 0;
  double merchantCodCharges = 0;
  double totalCashCollection = 0;
  double deliveryChargeAmount = 0;
  double codChargeAmount = 0;
  double packagingAmount = 0;
  double totalDeliveryChargeAmount = 0;
  double currentPayable = 0;
  double netPayable = 0;
  double myData = 0;
  double fragileLiquidAmounts = 0;




  TextEditingController pickupPhoneController = TextEditingController();
  TextEditingController pickupAddressController = TextEditingController();
  TextEditingController cashCollectionController = TextEditingController();
  TextEditingController sellingPriceController = TextEditingController();
  TextEditingController invoiceController = TextEditingController();
  TextEditingController customerController = TextEditingController();

  TextEditingController customerPhoneController = TextEditingController();
  TextEditingController customerAddressController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  Rx<TextEditingController> delivery_timeController = TextEditingController().obs;


  Future<void>  elivery_time_selectDateFromPicker(context) async {
    final DateTime? picked = await showDatePicker(
      context: context,

      initialDate:   DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      currentDate: DateTime.now(),
    );

    if (picked != null)
      delivery_timeController.value.text = "${picked.month}-${picked.day}-${picked.year} ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}";
  }


  var end_Lat = 0.0.obs;
  var end_Long = 0.0.obs;

  var customer_Lat = 0.0.obs;
  var customer_Long = 0.0.obs;


  List<ParcelEvents> parcelLogsList = <ParcelEvents>[];
  late Parcel parcel;


  Position? start_position;
  double? distanceImMeter=0.0;
  @override
  void onInit() async{
    getParcel();
    distanceMatrixServiceLatLong();
    ///////////////////////
//     await Geolocator.checkPermission();
//     await Geolocator.requestPermission();
//     start_position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
//     print("position-latitude=${start_position}");
//     print("position-latitude=${start_position?.latitude}");
//     print("position-longitude=${start_position?.longitude}");
//
//     distanceImMeter = await Geolocator.distanceBetween(
//         customer_Lat.toDouble(),
//         customer_Long.toDouble(),
//         end_Lat.toDouble(),
//         end_Long.toDouble()
//     );
//
//
// print("distanceImMeter${distanceImMeter!/1000}");

    // incrementStoreFollowers(end_Lat, end_Long, customer_Lat, customer_Long);


    print("Fahad object${total_delivery_ammount}");
    super.onInit();
  }

  GlobalController globalController=GlobalController();

  getParcelList() async {
    loader = true;
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
    getParcel();
  }

  getParcel() {
    server.getRequest(endPoint: APIList.parcelList).then((response) {
      print(json.decode(response.body));
      if (response != null && response.statusCode == 200) {
        loader = false;
        final jsonResponse = json.decode(response.body);
        var parcelData = ParcelsModel.fromJson(jsonResponse);
        parcelList = <Parcels>[];
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

  getParcelLogs(id) {
    loaderLogs = true;
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
    parcelLogsList = <ParcelEvents>[];
    server.getRequest(endPoint: APIList.parcelLogs!+id.toString()).then((response) {
      if (response != null && response.statusCode == 200) {
        loaderLogs = false;
        final jsonResponse = json.decode(response.body);
        var parcelData = ParcelLogsModel.fromJson(jsonResponse);
        parcelLogsList = <ParcelEvents>[];
        parcelLogsList.addAll(parcelData.data!.parcelEvents!);
        parcel = parcelData.data!.parcel!;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {
        loaderLogs = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      }
    });
  }

  var catagoryList = <DeliveryCategory>[].obs;
  crateParcel() {
    server.getRequest(endPoint: APIList.parcelCreate).then((response) {
      print("object=Fahad=${response.body}");
      if (response != null && response.statusCode == 200) {
        loader = false;
        final jsonResponse = json.decode(response.body);
        var data = ParcelCrateModel.fromJson(jsonResponse);
        fragileLiquidAmount = double.parse(data.data!.fragileLiquid.toString());
        print(fragileLiquidAmount);
        merchantData = data.data!.merchant!;
        vatTax = double.parse(merchantData.vat.toString());
        shopList = <Shop>[];
        shopList.addAll(data.data!.shops!);
        print("shopList${shopList.length}");
        packagingList = <Packaging>[];
        packagingList.add(Packaging(id:0,name: 'select_packaging'.tr,price: '0',));
        packagingList.addAll(data.data!.packagings!);
        deliveryChargesList = <DeliveryCharge>[];
        // deliveryChargesList.add(DeliveryCharge(id:0,category: 'select_category',weight: '0',));
        deliveryChargesList.add(DeliveryCharge(id:0,weight: '0',));
        deliveryChargesList.addAll(data.data!.deliveryCharges!);
        deliveryCategoryList = <DeliveryCategory>[];
        deliveryCategoryList.add(DeliveryCategory(id: 0,title: "Select Vehicle Type".tr,));
        deliveryCategoryList.addAll(data.data!.deliveryCategories!);

        // List<DeliveryCategory>? category = data.data?.deliveryCategories;
        //
        // for (var i in category) {
        //   catagoryList.add(i);
        // }

        if(shopList.isNotEmpty){
          pickupPhone = shopList[shopIndex].contactNo.toString();
          pickupAddress = shopList[shopIndex].address.toString();
          shopID = shopList[shopIndex].id.toString();
        }

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

  parcelPost() {
    loaderParcel = true;
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
    Map chargeDetails = {
      'vatTex': merchantData.vat,
      'VatAmount': vatAmount.toStringAsFixed(2),
      'deliveryChargeAmount': deliveryChargeAmount.toStringAsFixed(2),
      'codChargeAmount': codChargeAmount.toStringAsFixed(2),
      'totalDeliveryChargeAmount': totalDeliveryChargeAmount.toStringAsFixed(2),
      'currentPayable': currentPayable.toStringAsFixed(2),
      'packagingAmount': packagingAmount.toStringAsFixed(2),
      'liquidFragileAmount': fragileLiquidAmounts.toStringAsFixed(2),
    };

    Map body = {
      'chargeDetails': jsonEncode(chargeDetails),
      'shop_id': shopID,
      'weight': deliveryChargesValue.weight == '0'?'':deliveryChargesValue.weight,
      'pickup_phone': pickupPhoneController.text.toString(),
      'pickup_address': pickupAddressController.text.toString(),
      'invoice_no': invoiceController.text.toString(),
      'cash_collection': cashCollectionController.text.toString(),
      'category_id': deliveryCategorysValue.id.toString(),
      'delivery_type_id': deliveryTypID == 'Next Day'? 1: deliveryTypID == 'Same Day'?2: deliveryTypID == 'Sub City'?3: deliveryTypID == 'Outside City'?4:'',
      // 'selling_price': sellingPriceController.text.toString(),
      'selling_price': "",
      'customer_name': customerController.text.toString(),
      'customer_address': customerAddressController.text.toString(),
      'customer_phone': customerPhoneController.text.toString(),
      'note': noteController.text.toString(),
      'pickup_lat': end_Lat.value,
      'pickup_long': end_Long.value,
      'customer_lat': customer_Lat.value,
      'customer_long': customer_Long.value,
      'delivery_time': delivery_timeController.value.text,
      'parcel_bank': isParcelBankCheck ? 'on':'',
      'packaging_id': packagingID == '0'?'':packagingID,
      'fragileLiquid': isLiquidChecked ? 'on':'',

    };

    String jsonBody = json.encode(body);
    print(jsonBody);

    server
        .postRequestWithToken(endPoint: APIList.parcelStore, body: jsonBody)
        .then((response) {
          print("under ${response}");
          print("under ${response.statusCode}");
          print("under${response.body}");
      if (response != null && response.statusCode == 200) {
            print("under yes${response}");
            print("under yes${response.statusCode}");
            print("under yes${response.body}");
        final jsonResponse = json.decode(response.body);
        clearAll();
        loaderParcel = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
        getParcelList();
        Get.back();
        Get.rawSnackbar(
            message: "${jsonResponse['message']}",
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.TOP);
      } else if (response != null && response.statusCode == 422) {
        print("under notb ${response}");
        print("under notb ${response.statusCode}");
        print("under notb ${response.body}");
        loaderParcel = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {
        loaderParcel = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
        Get.rawSnackbar(message: 'Please enter valid input');
      }
    });
  }


  clearAll() {
      fragileLiquidAmount = 0;
      fragileLiquidAmounts = 0;
      shopIndex = 0;
      packagingIndex = 0;
      deliveryChargesIndex = 0;
      deliveryChargesValue = DeliveryCharges();
      pickupPhone = '';
      pickupAddress = '';
      shopID = '';
      packagingID = '';
      packagingPrice = '0';
      deliveryChargesID = '';
      deliveryTypID = 'Same Day';
      deliveryChargesPrice = '0';
      isLiquidChecked = false;
      isParcelBankCheck = false;
      pickupPhoneController.text = '';
      pickupAddressController.text = '';
      cashCollectionController.text = '';
      sellingPriceController.text = '';
      invoiceController.text = '';
      customerController.text = '';
      customerPhoneController.text = '';
      customerAddressController.text = '';
      noteController.text = '';
      vatTax = 0;
      vatAmount = 0;
      merchantCodCharges = 0;
      totalCashCollection = 0;
      deliveryChargeAmount = 0;
      codChargeAmount = 0;
      packagingAmount = 0;
      totalDeliveryChargeAmount = 0;
      currentPayable = 0;
     netPayable = 0;

    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
  }



  // dynamic storeFollowerCount;
  //  incrementStoreFollowers(end_Lat,end_Long,customer_Lat,customer_Long,) async {
  //   try {
  //     var response = await Dio().get('https://maps.googleapis.com/maps/api/distancematrix/json?destinations=$end_Lat,$end_Long&origins=$customer_Lat,$customer_Long&key=AIzaSyBxwyLXWNfom9BRx0Ccr_PdIzDCHyKDeNo');
  //     final jsonData = response.data;
  //     if (jsonData['status'] == 'OK') {
  //       print('Delivery Charge Sajib==> '+ '${(jsonData['rows'][0]['elements'][0]['distance']['value'] / 1000)}');
  //       return  storeFollowerCount = (jsonData['rows'][0]['elements'][0]['distance']['value'] / 1000);
  //     }else{
  //       return 0.00;
  //     }
  //   } catch (e) {
  //     print(e);
  //     return 0.00;
  //   }
  // }

  dynamic total_delivery_ammount;

  distanceMatrixServiceLatLong() async {
    loaderParcel = true;
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });

    Map body = {
      'category_id': deliveryCategorysValue.id.toString(),
      'delivery_type_id': deliveryTypID == 'Next Day'? 1: deliveryTypID == 'Same Day'?2: deliveryTypID == 'Sub City'?3: deliveryTypID == 'Outside City'?4:'',
      'pickup_lat': end_Lat.value,
      'pickup_long': end_Long.value,
      'customer_lat': customer_Lat.value,
      'customer_long': customer_Long.value,
    };
    var jsonBody = json.encode(body);
    // print("jsonBody${jsonBody}");
    server.postRequestWithToken(endPoint: APIList.parcelCreate1, body: jsonBody)
        .then((response) {
      // print("distanceMatrixServiceLatLong ${response}");
      // print("distanceMatrixServiceLatLong ${response.statusCode}");
      // print("distanceMatrixServiceLatLong${response.body}");

      if (response != null && response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print("distanceMatrixServiceLatLong notb ${response}");
        print("distanceMatrixServiceLatLong notb ${response.statusCode}");
        print("distanceMatrixServiceLatLong notb ${response.body}");
        print("Sajib ${total_delivery_ammount=(jsonResponse.body['data']['delivery_charge'])}");
        loaderParcel = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });

        // getParcelList();
        // Get.rawSnackbar(
        //     message: "${jsonResponse['message']}",
        //     backgroundColor: Colors.green,
        //     snackPosition: SnackPosition.TOP);

        return total_delivery_ammount=(jsonResponse.body['data']['delivery_charge']);

      } else if (response != null && response.statusCode == 422) {

        print("distanceMatrixServiceLatLong notb ${response}");
        print("distanceMatrixServiceLatLong notb ${response.statusCode}");
        print("distanceMatrixServiceLatLong notb ${response.body}");
        loaderParcel = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });

      }

      else {
        loaderParcel = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });

      }
    });
  }

  void calculateTotal(context) {
      totalDeliveryChargeAmount   = 0;
      totalCashCollection = 0;
      codChargeAmount = 0;
      totalDeliveryChargeAmount = 0;
      vatAmount = 0;
      netPayable = 0;
      currentPayable = 0;
      merchantCodCharges = 0;
      packagingAmount = 0;
      fragileLiquidAmounts = 0;

      double? deliveryChargeAmount =  0;
      double merchantCodCharge    = 0;

      if(deliveryTypID == 'Same Day'){
        // deliveryChargeAmount = deliveryChargesValue.sameDay.toDouble();
        merchantCodCharge = merchantData.codCharges!.insideCity.toDouble();
        }else if (deliveryTypID == 'Next Day') {
        // deliveryChargeAmount = deliveryChargesValue.nextDay.toDouble();
        merchantCodCharge = merchantData.codCharges!.insideCity.toDouble();
      } else if (deliveryTypID == 'Sub City') {
        // deliveryChargeAmount = deliveryChargesValue.subCity.toDouble();
        merchantCodCharge = merchantData.codCharges!.subCity.toDouble();
      }else if (deliveryTypID == 'Outside City') {
        // deliveryChargeAmount = deliveryChargesValue.outsideCity.toDouble();
        merchantCodCharge = merchantData.codCharges!.outsideCity.toDouble();
      }else {
          deliveryChargeAmount = 0;
          merchantCodCharge = 0;
      }


       packagingAmount = double.parse(packagingPrice.toString());
       totalCashCollection          =  double.parse(cashCollectionController.text.toString());
       codChargeAmount              =  percentage(totalCashCollection, merchantCodCharge);
       if(isLiquidChecked){
         totalDeliveryChargeAmount    = (deliveryChargeAmount+codChargeAmount+fragileLiquidAmount+packagingAmount);
         fragileLiquidAmounts = fragileLiquidAmount;
       }else {
         totalDeliveryChargeAmount    = (deliveryChargeAmount+codChargeAmount+packagingAmount);
         fragileLiquidAmounts = 0;
       }

      vatAmount                    = percentage(totalDeliveryChargeAmount, vatTax);
      netPayable                   = (totalDeliveryChargeAmount + vatAmount);
      currentPayable               = (totalCashCollection - (totalDeliveryChargeAmount + vatAmount));
      merchantCodCharges           = merchantCodCharge;

      // print("distance==${storeFollowerCount} km");
      // print("perKilometerRate==${perKilometerRate} ");
      // print("distance*perKilometerRate==${storeFollowerCount!*(perKilometerRate)}");

       print('packagingAmount==> '+ '${total_delivery_ammount}');
       print('packagingAmount==> '+ '${packagingAmount}');
       print('deliveryChargeAmount==> '+ '${deliveryChargeAmount}');
       print('totalDeliveryChargeAmount==> '+ '${totalDeliveryChargeAmount}');
       print('totalCashCollection==> '+ '${totalCashCollection}');
       print('vatAmount==> '+ '${vatAmount}');
       print('codChargeAmount==> '+ '${codChargeAmount}');
       print('netPayable==> '+ '${netPayable}');
       print('currentPayable==> '+ '${currentPayable}');
       showPopUp(context, totalCashCollection,deliveryChargeAmount,codChargeAmount,fragileLiquidAmounts,packagingAmount,totalDeliveryChargeAmount,vatAmount,netPayable,currentPayable);
      Future.delayed(Duration(milliseconds: 10), () {
      update();
      });
  }

  percentage(totalAmount,percentageAmount) {
    return totalAmount * (percentageAmount / 100);
  }





  void showPopUp(context, totalCashCollectionParcel,deliveryChargeAmountParcel,codChargeAmountParcel,fragileLiquidAmountsParcel,packagingAmountParcel,totalDeliveryChargeAmountParcel,vatAmountParcel,netPayableParcel,currentPayableParcel) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child:  SingleChildScrollView(
             child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'charge_details'.tr,
                    style: kTextStyle.copyWith(
                        color: kSecondaryColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  ListTile(
                    title: Text(
                      'title'.tr,
                      style: kTextStyle.copyWith(
                          color: kTitleColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                    trailing: Text(
                      'amount_tk'.tr,
                      style: kTextStyle.copyWith(
                          color: kTitleColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(
                        'cash_collection'.tr,
                        style: kTextStyle.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        '${totalCashCollectionParcel.toStringAsFixed(2)}',
                        style: kTextStyle.copyWith(color: kTitleColor),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(
                        'delivery_charges'.tr,
                        style: kTextStyle.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        '${deliveryChargeAmountParcel.toStringAsFixed(2)}',
                        style: kTextStyle.copyWith(color: kTitleColor),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(
                        'cod_charge'.tr,
                        style: kTextStyle.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        '${codChargeAmountParcel.toStringAsFixed(2)}',
                        style: kTextStyle.copyWith(color: kTitleColor),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(
                        'liquid_fragile_charge'.tr,
                        style: kTextStyle.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        '${fragileLiquidAmountsParcel.toStringAsFixed(2)}',
                        style: kTextStyle.copyWith(color: kTitleColor),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(
                        'p_charge'.tr,
                        style: kTextStyle.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        '${packagingAmountParcel.toStringAsFixed(2)}',
                        style: kTextStyle.copyWith(color: kTitleColor),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(
                        'total_charge'.tr,
                        style: kTextStyle.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        '${totalDeliveryChargeAmountParcel.toStringAsFixed(2)}',
                        style: kTextStyle.copyWith(color: kTitleColor),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(
                        'vat'.tr,
                        style: kTextStyle.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        '${vatAmountParcel.toStringAsFixed(2)}',
                        style: kTextStyle.copyWith(color: kTitleColor),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(
                        'net_payable'.tr,
                        style: kTextStyle.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        '${netPayableParcel.toStringAsFixed(2)}',
                        style: kTextStyle.copyWith(color: kTitleColor),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(
                        'current_payable'.tr,
                        style: kTextStyle.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        '${currentPayableParcel.toStringAsFixed(2)}',
                        style: kTextStyle.copyWith(color: kTitleColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  ButtonGlobal(buttontext: 'confirm'.tr, buttonDecoration: kButtonDecoration, onPressed: (){
                    FocusScope.of(context).requestFocus(new FocusNode());
                    parcelPost();
                    // distanceMatrixServiceLatLong();
                    Get.back();
                    // Get.off(ParcelPage());
                  })
                ],
              )),
            ),
          );
        });
  }

}
