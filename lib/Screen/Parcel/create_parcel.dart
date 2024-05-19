import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:we_courier_merchant_app/Models/edit_parcel_model.dart';
import 'package:we_courier_merchant_app/Screen/MapScreen/pickup_map.dart';


import '../MapScreen/customer_map.dart';
import '/Screen/Widgets/button_global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../Controllers/parcel_controller.dart';
import '../../Models/parcel_crate_model.dart';
import '../../utils/size_config.dart';
import '../Widgets/constant.dart';
import '../Widgets/loader.dart';

class CreateParcel extends StatefulWidget {
  const CreateParcel({Key? key}) : super(key: key);

  @override
  State<CreateParcel> createState() => _CreateParcelState();
}

class _CreateParcelState extends State<CreateParcel> {

  ParcelController parcelController = Get.put(ParcelController());
  final _formKey = GlobalKey<FormState>();
  int hub = 1;
  bool is_check=false;
  List<String> deliveryType = [
    'Parcel',
    'Food',
    'Van',
    'Next Day',
  ];
  String type = 'Parcel';

  DropdownButton<String> selectType() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String des in deliveryType) {
      var item = DropdownMenuItem(
        value: des,
        child: Text(des),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      items: dropDownItems,
      value: type,
      onChanged: (value) {
        setState(() {
          type = value!;
          Get.find<ParcelController>().deliveryTypID = type;
        });
      },
    );
  }

  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    parcelController.crateParcel();
    parcelController.distanceMatrixServiceLatLong();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    SizeConfigCustom sizeConfig = SizeConfigCustom();
    sizeConfig.init(context);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: kMainColor,
        appBar: AppBar(
          titleSpacing: 0,
          title: Text(
            '    Create Order'.tr,
            style: kTextStyle.copyWith(color: kBgColor),
          ),
          // leading: IconButton(
          //     onPressed: () {
          //       Get.back();
          //       Get.find<ParcelController>().clearAll();
          //     },
          //     icon: Icon(
          //       Icons.arrow_back,
          //       color: kBgColor,
          //     )),
          backgroundColor: kMainColor,
          elevation: 0.0,
          iconTheme: const IconThemeData(color: kBgColor),
        ),
        // body: GetBuilder<ParcelController>(
        //     init: ParcelController(),
        //     builder: (parcel) => Stack(
        //         children: [
        //           Center(
        //             child: SingleChildScrollView(
        //               child: Column(
        //                 children: [
        //                   const SizedBox(height: 30.0),
        //                   Container(
        //                     padding: const EdgeInsets.all(10.0),
        //                     width: MediaQuery.of(context).size.width,
        //                     decoration: BoxDecoration(
        //                       border: Border.all(color: kGreyTextColor.withOpacity(0.2)),
        //                       borderRadius: const BorderRadius.only(
        //                         topLeft: Radius.circular(30.0),
        //                         topRight: Radius.circular(30.0),
        //                       ),
        //                       color: Colors.white,
        //                     ),
        //                     child: Form(
        //                         key: _formKey,
        //                         child: Column(
        //                           crossAxisAlignment: CrossAxisAlignment.start,
        //                           children: [
        //
        //
        //
        //                             const SizedBox(height: 20.0),
        //                             parcel.shopList.isEmpty
        //                                 ? SizedBox()
        //                                 :
        //                             SizedBox(
        //                               height: 60.0,
        //                               child: FormField(
        //                                 builder: (FormFieldState<dynamic> field) {
        //                                   return InputDecorator(
        //                                       decoration: kInputDecoration.copyWith(
        //                                         floatingLabelBehavior: FloatingLabelBehavior.always,
        //                                         labelText: 'shop'.tr,
        //                                         hintText: 'select_shop'.tr,
        //                                         labelStyle: kTextStyle.copyWith(color: kTitleColor),
        //                                         border: OutlineInputBorder(
        //                                           borderRadius: BorderRadius.circular(5.0),
        //                                         ),
        //                                       ),
        //
        //                                       child: DropdownButtonHideUnderline(
        //                                         child: DropdownButton<Shop>(
        //                                           value: parcel.shopIndex.toString() == 'null' ? null : parcel.shopList[parcel.shopIndex],
        //                                           items: parcel.shopList.map((Shop value) {
        //                                             return new DropdownMenuItem<Shop>(
        //                                               value: value,
        //                                               child: Text(value.name.toString()),
        //                                             );
        //                                           }).toList(),
        //                                           onChanged: (newValue) {
        //                                             setState(() {
        //                                               parcel.shopIndex = parcel.shopList.indexOf(newValue!);
        //                                               parcel.shopID = newValue.id.toString();
        //                                               parcel.pickupAddress = newValue.address.toString();
        //                                               parcel.pickupPhone = newValue.contactNo.toString();
        //                                             });
        //                                           },
        //                                         ),
        //                                       ));
        //                                 },
        //                               ),
        //                             ),
        //
        //
        //                             const SizedBox(height: 20.0),
        //                             AppTextField(
        //                               onChanged: (value) {
        //                                 setState(() {
        //                                   parcel.pickupPhone = parcel.pickupPhoneController.text;
        //                                 });
        //                               },
        //
        //                               controller: parcel.pickupPhoneController
        //                                 ..text = parcel.pickupPhone.toString()
        //                                 ..selection = TextSelection.collapsed(offset: parcel.pickupPhoneController.text.length),
        //                               showCursor: true,
        //                               validator: (value) {
        //                                 if (parcel.pickupPhoneController.text.isEmpty) {
        //                                   return "this_field_can_t_be_empty".tr;
        //                                 }
        //                                 return null;
        //                               },
        //                               cursorColor: kTitleColor,
        //                               textFieldType: TextFieldType.PHONE,
        //                               decoration: kInputDecoration.copyWith(
        //                                 enabledBorder: const OutlineInputBorder(
        //                                   borderRadius: BorderRadius.all(Radius.circular(2.0)),
        //                                   borderSide: BorderSide(color: kBorderColorTextField, width: 2),
        //                                 ),
        //                                 labelText: 'pickup_phone'.tr,
        //                                 labelStyle: kTextStyle.copyWith(color: kTitleColor),
        //                                 hintText: '017XXXXXXXX',
        //                                 hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
        //                               ),
        //                             ),
        //                             const SizedBox(height: 20.0),
        //                             // AppTextField(
        //                             //   onChanged: (value) {
        //                             //     setState(() {
        //                             //       parcel.pickupAddress = parcel.pickupAddressController.text;
        //                             //     });
        //                             //   },
        //                             //   controller: parcel.pickupAddressController
        //                             //     ..text = parcel.pickupAddress.toString()
        //                             //     ..selection = TextSelection.collapsed(offset: parcel.pickupAddressController.text.length),
        //                             //   showCursor: true,
        //                             //   validator: (value) {
        //                             //     if (parcel.pickupAddressController.text.isEmpty) {
        //                             //       return "this_field_can_t_be_empty".tr;
        //                             //     }
        //                             //     return null;
        //                             //   },
        //                             //   cursorColor: kTitleColor,
        //                             //   textFieldType: TextFieldType.NAME,
        //                             //   decoration: kInputDecoration.copyWith(
        //                             //     enabledBorder: const OutlineInputBorder(
        //                             //       borderRadius: BorderRadius.all(Radius.circular(2.0)),
        //                             //       borderSide: BorderSide(color: kBorderColorTextField, width: 2),
        //                             //     ),
        //                             //     labelText: 'pickup_address'.tr,
        //                             //     labelStyle: kTextStyle.copyWith(color: kTitleColor),
        //                             //     hintText: 'enter_address'.tr,
        //                             //     hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
        //                             //   ),
        //                             // ),
        //                             AppTextField(
        //                               onChanged: (value) {
        //                                 setState(() {
        //                                   parcel.pickupAddress = parcel.pickupAddressController.text;
        //                                 });
        //                               },
        //                               // controller: parcel.pickupAddressController,
        //                               controller: parcel.pickupAddressController..text = parcel.pickupAddress.toString()..selection = TextSelection.collapsed(offset: parcel.pickupAddressController.text.length),
        //                               validator: (value) {
        //                                 if (parcel.pickupAddressController.text.isEmpty) {
        //                                   return "this_field_can_t_be_empty".tr;
        //                                 }
        //                                 return null;
        //                               },
        //                               cursorColor: kTitleColor,
        //                               textFieldType: TextFieldType.NAME,
        //                               decoration: kInputDecoration.copyWith(
        //                                   enabledBorder: const OutlineInputBorder(
        //                                     borderRadius: BorderRadius.all(Radius.circular(2.0)),
        //                                     borderSide: BorderSide(color: kBorderColorTextField, width: 2),
        //                                   ),
        //                                   labelText: 'pickup_address'.tr,
        //                                   labelStyle: kTextStyle.copyWith(color: kTitleColor),
        //                                   hintText: 'enter_address'.tr,
        //                                   hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
        //                                   suffixIcon: InkWell(
        //                                       onTap: () {
        //                                         Get.to(PickupMapsScreen());
        //                                       },
        //                                       child: Icon(Icons.location_on))
        //                               ),
        //                             ),
        //
        //
        //
        //
        //
        //
        //
        //                             const SizedBox(height: 10.0),
        //                             Text(" Customer Details",
        //                                 style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
        //                             const SizedBox(height: 5.0),
        //                             AppTextField(
        //                               controller: parcel.customerController,
        //                               validator: (value) {
        //                                 if (parcel.customerController.text.isEmpty) {
        //                                   return "this_field_can_t_be_empty".tr;
        //                                 }
        //                                 return null;
        //                               },
        //                               cursorColor: kTitleColor,
        //                               textFieldType: TextFieldType.NAME,
        //                               decoration: kInputDecoration.copyWith(
        //                                 enabledBorder: const OutlineInputBorder(
        //                                   borderRadius: BorderRadius.all(Radius.circular(2.0)),
        //                                   borderSide: BorderSide(color: kBorderColorTextField, width: 2),
        //                                 ),
        //                                 labelText: 'customer_name'.tr + '*',
        //                                 labelStyle: kTextStyle.copyWith(color: kTitleColor),
        //                                 hintText: 'customer_name'.tr,
        //                                 hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
        //                               ),
        //                             ),
        //                             const SizedBox(height: 20.0),
        //                             AppTextField(
        //                               controller: parcel.customerPhoneController,
        //                               validator: (value) {
        //                                 if (parcel.customerPhoneController.text.isEmpty) {
        //                                   return "this_field_can_t_be_empty".tr;
        //                                 }
        //                                 return null;
        //                               },
        //                               cursorColor: kTitleColor,
        //                               textFieldType: TextFieldType.PHONE,
        //                               decoration: kInputDecoration.copyWith(
        //                                 enabledBorder: const OutlineInputBorder(
        //                                   borderRadius: BorderRadius.all(Radius.circular(2.0)),
        //                                   borderSide: BorderSide(color: kBorderColorTextField, width: 2),
        //                                 ),
        //                                 labelText: 'customer_phone'.tr + '*',
        //                                 labelStyle: kTextStyle.copyWith(color: kTitleColor),
        //                                 hintText: 'customer_phone'.tr,
        //                                 hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
        //                               ),
        //                             ),
        //                             const SizedBox(height: 20.0),
        //
        //                             // Column(
        //                             //   mainAxisAlignment: MainAxisAlignment.center,
        //                             //   mainAxisSize: MainAxisSize.min,
        //                             //   children: <Widget>[
        //                             //     Padding(
        //                             //       padding: const EdgeInsets.all(8.0),
        //                             //       child: FlutterGooglePlacesWeb(apiKey: APIList.mapGoogleApiKey!, required: true, controller: parcel.customerAddressController,),
        //                             //     ),
        //                             //   ],
        //                             // ),
        //                             AppTextField(
        //
        //                               onChanged: (value) {
        //                                 setState(() {
        //                                   parcel.customerAddress = parcel.customerAddressController.text;
        //                                 });
        //                               },
        //                               // controller: parcel.pickupAddressController,
        //                               controller: parcel.customerAddressController..text = parcel.customerAddress.toString()..selection = TextSelection.collapsed(offset: parcel.customerAddressController.text.length),
        //                               validator: (value) {
        //                                 if (parcel.customerAddressController.text.isEmpty) {
        //                                   return "this_field_can_t_be_empty".tr;
        //                                 }
        //                                 return null;
        //                               },
        //                               cursorColor: kTitleColor,
        //                               textFieldType: TextFieldType.NAME,
        //                               decoration: kInputDecoration.copyWith(
        //                                   enabledBorder: const OutlineInputBorder(
        //                                     borderRadius: BorderRadius.all(Radius.circular(2.0)),
        //                                     borderSide: BorderSide(color: kBorderColorTextField, width: 2),
        //                                   ),
        //                                   labelText: 'Customer Address'.tr,
        //                                   labelStyle: kTextStyle.copyWith(color: kTitleColor),
        //                                   hintText: 'enter_address'.tr,
        //                                   hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
        //                                   suffixIcon: InkWell(
        //                                       onTap: () {
        //                                         Get.to(CustomerMapsScreen());
        //                                       },
        //                                       child: Icon(Icons.location_on))
        //                               ),
        //                             ),
        //
        //
        //                             // const SizedBox(height: 20.0),
        //                             // Text(
        //                             //   'choose_which_needed_for_parcel'.tr,
        //                             //   style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold, fontSize: 18.0),
        //                             // ),
        //                             // Row(
        //                             //   children: [
        //                             //     Checkbox(
        //                             //       activeColor: kMainColor,
        //                             //       shape: RoundedRectangleBorder(
        //                             //         borderRadius: BorderRadius.circular(2.0),
        //                             //       ),
        //                             //       value: parcel.isLiquidChecked,
        //                             //       onChanged: (val) {
        //                             //         setState(
        //                             //           () {
        //                             //             parcel.isLiquidChecked = val!;
        //                             //           },
        //                             //         );
        //                             //       },
        //                             //     ),
        //                             //     Text(
        //                             //       'liquid_fragile'.tr,
        //                             //       style: kTextStyle.copyWith(color: kTitleColor),
        //                             //     ),
        //                             //   ],
        //                             // ),
        //                             // Row(
        //                             //   children: [
        //                             //     Checkbox(
        //                             //       activeColor: kMainColor,
        //                             //       shape: RoundedRectangleBorder(
        //                             //         borderRadius: BorderRadius.circular(2.0),
        //                             //       ),
        //                             //       value: parcel.isParcelBankCheck,
        //                             //       onChanged: (val) {
        //                             //         setState(
        //                             //           () {
        //                             //             parcel.isParcelBankCheck = val!;
        //                             //           },
        //                             //         );
        //                             //       },
        //                             //     ),
        //                             //     Text(
        //                             //       'is_it_parcel_bank'.tr + '?',
        //                             //       style: kTextStyle.copyWith(color: kTitleColor),
        //                             //     ),
        //                             //   ],
        //                             // ),
        //                             // const SizedBox(height: 20.0),
        //                             // parcel.packagingList.isEmpty
        //                             //     ? SizedBox()
        //                             //     : SizedBox(
        //                             //         height: 60.0,
        //                             //         child: FormField(
        //                             //           builder: (FormFieldState<dynamic> field) {
        //                             //             return InputDecorator(
        //                             //               decoration: kInputDecoration.copyWith(
        //                             //                 floatingLabelBehavior: FloatingLabelBehavior.always,
        //                             //                 labelText: 'packaging'.tr,
        //                             //                 hintText: 'select_packaging'.tr,
        //                             //                 labelStyle: kTextStyle.copyWith(color: kTitleColor),
        //                             //                 border: OutlineInputBorder(
        //                             //                   borderRadius: BorderRadius.circular(5.0),
        //                             //                 ),
        //                             //               ),
        //                             //               child: DropdownButtonHideUnderline(
        //                             //                 child: DropdownButton<Packagings>(
        //                             //                   value: parcel.packagingIndex.toString() == 'null' ? null : parcel.packagingList[parcel.packagingIndex],
        //                             //                   items: parcel.packagingList.map((Packagings value) {
        //                             //                     return new DropdownMenuItem<Packagings>(
        //                             //                       value: value,
        //                             //                       child: value.id == 0 ? Text(value.name.toString()) : Text(value.name.toString() + ' (${value.price.toString()})'),
        //                             //                     );
        //                             //                   }).toList(),
        //                             //                   onChanged: (newValue) {
        //                             //                     setState(() {
        //                             //                       parcel.packagingIndex = parcel.packagingList.indexOf(newValue!);
        //                             //                       parcel.packagingID = newValue.id.toString();
        //                             //                       parcel.packagingPrice = newValue.price.toString();
        //                             //                     });
        //                             //                   },
        //                             //                 ),
        //                             //               ),
        //                             //             );
        //                             //           },
        //                             //         ),
        //                             //       ),
        //                             const SizedBox(height: 10.0),
        //                             Text(" Parcel Details", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
        //                             const SizedBox(height: 10.0),
        //
        //                             AppTextField(
        //                               controller: parcel.cashCollectionController,
        //                               validator: (value) {
        //                                 if (parcel.cashCollectionController.text.isEmpty) {
        //                                   return "this_field_can_t_be_empty".tr;
        //                                 }
        //                                 return null;
        //                               },
        //                               cursorColor: kTitleColor,
        //                               textFieldType: TextFieldType.NAME,
        //                               decoration: kInputDecoration.copyWith(
        //                                 enabledBorder: const OutlineInputBorder(
        //                                   borderRadius: BorderRadius.all(Radius.circular(2.0)),
        //                                   borderSide: BorderSide(color: kBorderColorTextField, width: 2),
        //                                 ),
        //                                 labelText: 'COD Amount'.tr,
        //                                 labelStyle: kTextStyle.copyWith(color: kTitleColor),
        //                                 hintText: 'enter_amount'.tr,
        //                                 hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
        //                               ),
        //                             ),
        //                             // const SizedBox(height: 20.0),
        //                             //
        //                             // AppTextField(
        //                             //   controller: parcel.sellingPriceController,
        //                             //   cursorColor: kTitleColor,
        //                             //   textFieldType: TextFieldType.NAME,
        //                             //   decoration: kInputDecoration.copyWith(
        //                             //     enabledBorder: const OutlineInputBorder(
        //                             //       borderRadius: BorderRadius.all(Radius.circular(2.0)),
        //                             //       borderSide: BorderSide(color: kBorderColorTextField, width: 2),
        //                             //     ),
        //                             //     labelText: 'selling_price'.tr,
        //                             //     labelStyle: kTextStyle.copyWith(color: kTitleColor),
        //                             //     hintText: 'selling_price_of_parcel'.tr,
        //                             //     hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
        //                             //   ),
        //                             // ),
        //                             const SizedBox(height: 20.0),
        //                             SizedBox(
        //                               height: 60.0,
        //                               child: FormField(
        //                                 builder: (FormFieldState<dynamic> field) {
        //                                   return InputDecorator(
        //                                     decoration: kInputDecoration.copyWith(
        //                                       floatingLabelBehavior: FloatingLabelBehavior.always,
        //                                       labelText: 'select_type'.tr + '*',
        //                                       hintText: 'delivery_type'.tr,
        //                                       labelStyle: kTextStyle.copyWith(color: kTitleColor),
        //                                       border: OutlineInputBorder(
        //                                         borderRadius: BorderRadius.circular(5.0),
        //                                       ),
        //                                     ),
        //                                     child: DropdownButtonHideUnderline(
        //                                       child: selectType(),
        //                                     ),
        //                                   );
        //                                 },
        //                               ),
        //                             ),
        //                             const SizedBox(height: 20.0),
        //                             parcel.deliveryCategoryList.isEmpty
        //                                 ? SizedBox()
        //                                 : SizedBox(
        //                               height: 60.0,
        //                               child: FormField(
        //                                 builder: (FormFieldState<dynamic> field) {
        //                                   return InputDecorator(
        //                                     decoration: kInputDecoration.copyWith(
        //                                       floatingLabelBehavior: FloatingLabelBehavior.always,
        //                                       labelText: 'category'.tr + '*',
        //                                       hintText: 'select_category'.tr,
        //                                       labelStyle: kTextStyle.copyWith(color: kTitleColor),
        //                                       border: OutlineInputBorder(
        //                                         borderRadius: BorderRadius.circular(5.0),
        //                                       ),
        //                                     ),
        //
        //                                     child: DropdownButtonHideUnderline(
        //                                       child: DropdownButton<DeliveryCategory>(
        //                                         value: parcel.deliveryCategoryIndex.toString() == 'null' ? null : parcel.deliveryCategoryList[parcel.deliveryCategoryIndex],
        //                                         items: parcel.deliveryCategoryList.map((DeliveryCategory value) {
        //                                           return new DropdownMenuItem<DeliveryCategory>(
        //
        //                                             value: value,
        //                                             child: value.id == 0
        //                                                 ? Text(value.title.toString())
        //                                                 : value.title == '0'
        //                                                 ? Text(value.title.toString())
        //                                                 : Text(value.title.toString() ),
        //                                             // + ' (${value.weight.toString()})'
        //                                           );
        //                                         }).toList(),
        //                                         onChanged: (newValue) {
        //                                           setState(() {
        //                                             parcel.deliveryCategoryIndex = parcel.deliveryCategoryList.indexOf(newValue!);
        //                                             parcel.deliveryCategoryID = newValue.id.toString();
        //                                             parcel.deliveryCategorysValue = newValue;
        //                                           });
        //                                         },
        //                                       ),
        //                                     ),
        //                                   );
        //                                 },
        //                               ),
        //                             ),
        //
        //                             // parcel.deliveryChargesList.isEmpty
        //                             //     ? SizedBox()
        //                             //     : SizedBox(
        //                             //   height: 60.0,
        //                             //   child: FormField(
        //                             //     builder: (FormFieldState<dynamic> field) {
        //                             //       return InputDecorator(
        //                             //         decoration: kInputDecoration.copyWith(
        //                             //           floatingLabelBehavior: FloatingLabelBehavior.always,
        //                             //           labelText: 'category'.tr + '*',
        //                             //           hintText: 'select_category'.tr,
        //                             //           labelStyle: kTextStyle.copyWith(color: kTitleColor),
        //                             //           border: OutlineInputBorder(
        //                             //             borderRadius: BorderRadius.circular(5.0),
        //                             //           ),
        //                             //         ),
        //                             //
        //                             //         child: DropdownButtonHideUnderline(
        //                             //           child: DropdownButton<DeliveryCharge>(
        //                             //             value: parcel.deliveryChargesList.toString() == 'null' ? null : parcel.deliveryChargesList[parcel.deliveryChargesIndex],
        //                             //             items: parcel.deliveryChargesList.map((DeliveryCharge value) {
        //                             //               print("object=value ${value.category}");
        //                             //               return new DropdownMenuItem<DeliveryCharge>(
        //                             //
        //                             //                 value: value,
        //                             //                 child: value.id == 0
        //                             //                     ? Text(value.category.toString())
        //                             //                     : value.category == '0'
        //                             //                     ? Text(value.category.toString())
        //                             //                     : Text(value.category.toString() ),
        //                             //                 // + ' (${value.weight.toString()})'
        //                             //               );
        //                             //             }).toList(),
        //                             //             onChanged: (newValue) {
        //                             //               setState(() {
        //                             //                 parcel.deliveryChargesIndex = parcel.deliveryChargesList.indexOf(newValue!);
        //                             //                 parcel.deliveryChargesID = newValue.id.toString();
        //                             //                 parcel.deliveryChargesValue = newValue;
        //                             //               });
        //                             //             },
        //                             //           ),
        //                             //         ),
        //                             //       );
        //                             //     },
        //                             //   ),
        //                             // ),
        //
        //                             const SizedBox(height: 20.0),
        //
        //                             AppTextField(
        //                               controller: parcel.invoiceController,
        //                               cursorColor: kTitleColor,
        //                               isValidationRequired: false,
        //                               textFieldType: TextFieldType.NAME,
        //                               decoration: kInputDecoration.copyWith(
        //                                 enabledBorder: const OutlineInputBorder(
        //                                   borderRadius: BorderRadius.all(Radius.circular(2.0)),
        //                                   borderSide: BorderSide(color: kBorderColorTextField, width: 2),
        //                                 ),
        //                                 labelText: 'invoice'.tr + '#',
        //                                 labelStyle: kTextStyle.copyWith(color: kTitleColor),
        //                                 hintText: 'enter_invoice_number'.tr,
        //                                 hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
        //                               ),
        //                             ),
        //
        //                             SizedBox(height: 20.0),
        //                             TextFormField(
        //                               controller: parcel.noteController,
        //                               cursorColor: kTitleColor,
        //                               textAlign: TextAlign.start,
        //                               decoration: kInputDecoration.copyWith(
        //                                 labelText: 'note'.tr,
        //                                 labelStyle: kTextStyle.copyWith(color: kTitleColor),
        //                                 contentPadding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10.0),
        //                               ),
        //                             ),
        //                             const SizedBox(height: 20.0),
        //                             TextFormField(
        //                               readOnly: true,
        //                               onTap: () {
        //                                 parcel.elivery_time_selectDateFromPicker(context);
        //                               },
        //                               controller: parcel.delivery_timeController.value,
        //                               cursorColor: kTitleColor,
        //                               textAlign: TextAlign.start,
        //                               decoration: kInputDecoration.copyWith(
        //                                 labelText: 'Delivery Date'.tr,
        //                                 labelStyle: kTextStyle.copyWith(color: kTitleColor),
        //                                 contentPadding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10.0),
        //                                 suffixIcon: IconButton(onPressed: () {
        //                                   parcel.elivery_time_selectDateFromPicker(context);
        //                                 }, icon: Icon(Icons.calendar_today_outlined),),
        //                               ),
        //                               validator: (value) {
        //                                 if (value!.isEmpty) {
        //                                   return "Date Required".tr;
        //                                 }
        //                                 return null;
        //                               },
        //                             ),
        //
        //                             const SizedBox(height: 20.0),
        //                             ButtonGlobal(
        //                                 buttontext: 'submit'.tr,
        //                                 buttonDecoration: kButtonDecoration,
        //                                 onPressed: () {
        //
        //                                   setState(() {
        //                                     FocusScope.of(context).requestFocus(new FocusNode());
        //                                     if (_formKey.currentState!.validate()) {
        //                                       if (parcel.deliveryCategoryID != '' || parcel.deliveryTypID != '') {
        //                                         parcel.calculateTotal(context);
        //                                         parcel.distanceMatrixServiceLatLong();
        //                                       }
        //
        //                                       else if (parcel.deliveryCategoryID == '') {
        //                                         Get.rawSnackbar(message: "Please select category", backgroundColor: Colors.red, snackPosition: SnackPosition.TOP);
        //                                       }
        //
        //                                       else if (parcel.deliveryTypID == '') {
        //                                         Get.rawSnackbar(message: "Please select delivery type", backgroundColor: Colors.red, snackPosition: SnackPosition.TOP);
        //                                       } else {
        //                                         Get.rawSnackbar(message: "Please check information", backgroundColor: Colors.red, snackPosition: SnackPosition.TOP);
        //                                       }
        //                                     }
        //                                   });
        //                                 }
        //                             ),
        //
        //                           ],
        //                         )),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //           parcel.loaderParcel
        //               ? Positioned(
        //                   child: Container(height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width, color: Colors.white60, child: const Center(child: LoaderCircle())),
        //                 )
        //               : const SizedBox.shrink(),
        //         ]))
        body: GetBuilder<ParcelController>(
            init: ParcelController(),
            builder: (parcel) => Stack(
                children: [
                  Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border.all(color: kGreyTextColor.withOpacity(0.2)),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(0.0),
                                topRight: Radius.circular(0.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    const SizedBox(height: 20.0),
                               Container(

                                 width: double.infinity,
                                 child: Card(
                                   color: Colors.white,
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     children: [
                       Padding(
                         padding: const EdgeInsets.only(left: 15.0,top: 15.0),
                         child: Text("Pickup Information :",style: TextStyle(fontWeight: FontWeight.bold)),
                       ),
                                       Divider(),

                                       Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                                         Padding(
                                           padding: const EdgeInsets.only(left: 15.0,),
                                           child: Text("Instance Pickup",style: TextStyle(fontWeight: FontWeight.bold)),
                                         ),
                                         Checkbox(value: is_check,
                                           onChanged: (value) {
                                          setState(() {
                                            is_check=value!;
                                          });
                                         },)
                                       ],),
                                       parcel.shopList.isEmpty
                                           ? SizedBox()
                                           :
                                       Padding(
                                         padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                         child: SizedBox(
                                           height: 60.0,
                                           child: FormField(
                                             builder: (FormFieldState<dynamic> field) {
                                               return InputDecorator(
                                                   decoration: kInputDecoration.copyWith(
                                                     floatingLabelBehavior: FloatingLabelBehavior.always,
                                                     labelText: 'shop'.tr,
                                                     hintText: 'select_shop'.tr,
                                                     labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                                     border: OutlineInputBorder(
                                                       borderRadius: BorderRadius.circular(5.0),
                                                     ),
                                                   ),

                                                   child: DropdownButtonHideUnderline(
                                                     child: DropdownButton<Shop>(
                                                       value: parcel.shopIndex.toString() == 'null' ? null : parcel.shopList[parcel.shopIndex],
                                                       items: parcel.shopList.map((Shop value) {
                                                         return new DropdownMenuItem<Shop>(
                                                           value: value,
                                                           child: Text(value.name.toString()),
                                                         );
                                                       }).toList(),
                                                       onChanged: (newValue) {
                                                         setState(() {
                                                           parcel.shopIndex = parcel.shopList.indexOf(newValue!);
                                                           parcel.shopID = newValue.id.toString();
                                                           parcel.pickupAddress = newValue.address.toString();
                                                           parcel.pickupPhone = newValue.contactNo.toString();
                                                           parcel.pickup_plus_code = newValue.google_maps_plus_code.toString();
                                                           // parcel.end_Lat = newValue.merchantLat;
                                                           // parcel.end_Long = newValue.merchantLong;
                                                         });
                                                       },
                                                     ),
                                                   ));
                                             },
                                           ),
                                         ),
                                       ),


                                       const SizedBox(height: 20.0),
                                       Padding(
                                         padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                         child: AppTextField(
                                           onChanged: (value) {
                                             setState(() {
                                               parcel.pickupPhone = parcel.pickupPhoneController.text;
                                             });
                                           },

                                           controller: parcel.pickupPhoneController
                                             ..text = parcel.pickupPhone.toString()
                                             ..selection = TextSelection.collapsed(offset: parcel.pickupPhoneController.text.length),
                                           showCursor: true,
                                           validator: (value) {
                                             if (parcel.pickupPhoneController.text.isEmpty) {
                                               return "this_field_can_t_be_empty".tr;
                                             }
                                             return null;
                                           },
                                           cursorColor: kTitleColor,
                                           textFieldType: TextFieldType.PHONE,
                                           decoration: kInputDecoration.copyWith(
                                             enabledBorder: const OutlineInputBorder(
                                               borderRadius: BorderRadius.all(Radius.circular(2.0)),
                                               borderSide: BorderSide(color: kBorderColorTextField, width: 2),
                                             ),
                                             labelText: 'pickup_phone'.tr,
                                             labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                             hintText: '017XXXXXXXX',
                                             hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                                           ),
                                         ),
                                       ),
                                       const SizedBox(height: 20.0),
                                       // AppTextField(
                                       //   onChanged: (value) {
                                       //     setState(() {
                                       //       parcel.pickupAddress = parcel.pickupAddressController.text;
                                       //     });
                                       //   },
                                       //   controller: parcel.pickupAddressController
                                       //     ..text = parcel.pickupAddress.toString()
                                       //     ..selection = TextSelection.collapsed(offset: parcel.pickupAddressController.text.length),
                                       //   showCursor: true,
                                       //   validator: (value) {
                                       //     if (parcel.pickupAddressController.text.isEmpty) {
                                       //       return "this_field_can_t_be_empty".tr;
                                       //     }
                                       //     return null;
                                       //   },
                                       //   cursorColor: kTitleColor,
                                       //   textFieldType: TextFieldType.NAME,
                                       //   decoration: kInputDecoration.copyWith(
                                       //     enabledBorder: const OutlineInputBorder(
                                       //       borderRadius: BorderRadius.all(Radius.circular(2.0)),
                                       //       borderSide: BorderSide(color: kBorderColorTextField, width: 2),
                                       //     ),
                                       //     labelText: 'pickup_address'.tr,
                                       //     labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                       //     hintText: 'enter_address'.tr,
                                       //     hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                                       //   ),
                                       // ),
                                       Padding(
                                         padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                         child: AppTextField(
                                           onChanged: (value) {
                                             setState(() {
                                               parcel.pickupAddress = parcel.pickupAddressController.text;
                                             });
                                           },
                                           // controller: parcel.pickupAddressController,
                                           controller: parcel.pickupAddressController..text = parcel.pickupAddress.toString()..selection = TextSelection.collapsed(offset: parcel.pickupAddressController.text.length),
                                           validator: (value) {
                                             if (parcel.pickupAddressController.text.isEmpty) {
                                               return "this_field_can_t_be_empty".tr;
                                             }
                                             return null;
                                           },
                                           cursorColor: kTitleColor,
                                           textFieldType: TextFieldType.NAME,
                                           decoration: kInputDecoration.copyWith(
                                               enabledBorder: const OutlineInputBorder(
                                                 borderRadius: BorderRadius.all(Radius.circular(2.0)),
                                                 borderSide: BorderSide(color: kBorderColorTextField, width: 2),
                                               ),
                                               labelText: 'pickup_address'.tr,
                                               labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                               hintText: 'enter_address'.tr,
                                               hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                                               // suffixIcon: InkWell(
                                               //     onTap: () {
                                               //       Get.to(PickupMapsScreen());
                                               //     },
                                               //     child: Icon(Icons.location_on))
                                           ),
                                         ),
                                       ),

                                       const SizedBox(height: 20.0),

                                     ],
                                   ),
                                 ),
                               ),

                                    const SizedBox(height: 20.0),
                                    Container(

                                      width: double.infinity,
                                      child: Card(
                                        color: Colors.white,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 15.0,top: 15.0),
                                              child: Text("Customer Details :",style: TextStyle(fontWeight: FontWeight.bold)),
                                            ),
                                            Divider(),


                                            const SizedBox(height: 20.0),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                              child: AppTextField(
                                                controller: parcel.customerController,
                                                validator: (value) {
                                                  if (parcel.customerController.text.isEmpty) {
                                                    return "this_field_can_t_be_empty".tr;
                                                  }
                                                  return null;
                                                },
                                                cursorColor: kTitleColor,
                                                textFieldType: TextFieldType.NAME,
                                                decoration: kInputDecoration.copyWith(
                                                  enabledBorder: const OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(2.0)),
                                                    borderSide: BorderSide(color: kBorderColorTextField, width: 2),
                                                  ),
                                                  labelText: 'customer_name'.tr + '*',
                                                  labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                                  hintText: 'customer_name'.tr,
                                                  hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 20.0),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                              child: AppTextField(
                                                controller: parcel.customerPhoneController,
                                                validator: (value) {
                                                  if (parcel.customerPhoneController.text.isEmpty) {
                                                    return "this_field_can_t_be_empty".tr;
                                                  }
                                                  return null;
                                                },
                                                cursorColor: kTitleColor,
                                                textFieldType: TextFieldType.PHONE,
                                                decoration: kInputDecoration.copyWith(
                                                  enabledBorder: const OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(2.0)),
                                                    borderSide: BorderSide(color: kBorderColorTextField, width: 2),
                                                  ),
                                                  labelText: 'customer_phone'.tr + '*',
                                                  labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                                  hintText: 'customer_phone'.tr,
                                                  hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 20.0),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                              child: AppTextField(
                                                controller: parcel.cashCollectionController,
                                                validator: (value) {
                                                  if (parcel.cashCollectionController.text.isEmpty) {
                                                    return "this_field_can_t_be_empty".tr;
                                                  }
                                                  return null;
                                                },
                                                cursorColor: kTitleColor,
                                                textFieldType: TextFieldType.NAME,
                                                decoration: kInputDecoration.copyWith(
                                                  enabledBorder: const OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(2.0)),
                                                    borderSide: BorderSide(color: kBorderColorTextField, width: 2),
                                                  ),
                                                  labelText: 'Cash'.tr,
                                                  labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                                  hintText: 'enter_amount'.tr,
                                                  hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 20.0),
                                            parcel.googleMapsBlockList.isEmpty
                                                ? SizedBox()
                                                :
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                              child: SizedBox(
                                                height: 60.0,
                                                child: FormField(

                                                  builder: (FormFieldState<dynamic> field) {
                                                    return InputDecorator(
                                                      decoration: kInputDecoration.copyWith(
                                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                                        labelText: 'Block'.tr + '*',
                                                        labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                                        border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(5.0),
                                                        ),
                                                      ),
                                                      child: DropdownButtonHideUnderline(

                                                        child: DropdownButton2<GoogleMapsBlock>(
                                                          iconStyleData: IconStyleData(icon: Icon(Icons.search_outlined)),
                                                          hint: Text(
                                                            'Select Item',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: Theme.of(context).hintColor,
                                                            ),
                                                          ),
                                                          value: parcel.googleMapsBlockIndex.toString() == 'null' ? null : parcel.googleMapsBlockList[parcel.googleMapsBlockIndex],
                                                          items: parcel.googleMapsBlockList.map((GoogleMapsBlock value) {
                                                            return new DropdownMenuItem<GoogleMapsBlock>(
                                                              value: value,
                                                              child: value.id == 0
                                                                  ? Text("${value.blockName.toString()}")
                                                                  : value.blockName == ''
                                                                  ? Text("${value.blockNumber.toString()} ${value.blockName.toString()}")
                                                                  : Text("${value.blockNumber.toString()} ${value.blockName.toString()}"),
                                                            );
                                                          }).toList(),
                                                          onChanged: (newValue) {
                                                            setState(() {
                                                              parcel.googleMapsBlockIndex = parcel.googleMapsBlockList.indexOf(newValue!);
                                                              parcel.customerAddress = newValue.googleMapsPlusCode.toString();
                                                              // parcel.customer_Lat = newValue.latitude ? newValue.latitude : 0;
                                                              // parcel.customer_Long = newValue.longitude? newValue.longitude : 0;
                                                              parcel.distanceMatrixServiceLatLong();
                                                            });
                                                          },
                                                          buttonStyleData: const ButtonStyleData(
                                                            // padding: EdgeInsets.symmetric(horizontal: 16),
                                                            height: 40,
                                                            width: 400,
                                                          ),

                                                          dropdownSearchData: DropdownSearchData(

                                                            searchController: textEditingController,
                                                            searchInnerWidgetHeight: 50,
                                                            searchInnerWidget: Container(
                                                              height: 50,
                                                              padding: const EdgeInsets.only(
                                                                top: 8,
                                                                bottom: 4,
                                                                right: 8,
                                                                left: 8,
                                                              ),
                                                              child: TextFormField(

                                                                controller: textEditingController,
                                                                decoration: InputDecoration(
                                                                  contentPadding: const EdgeInsets.symmetric(
                                                                    horizontal: 10,
                                                                    vertical: 8,
                                                                  ),
                                                                  hintText: 'Search for an item...',
                                                                  hintStyle: const TextStyle(fontSize: 12),
                                                                  border: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(8),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),

                                                            searchMatchFn: (item, searchValue) {
                                                              return item.value!.blockNumber.toString().contains(searchValue);
                                                            },
                                                          ),
                                                          //This to clear the search value when you close the menu
                                                          onMenuStateChange: (isOpen) {
                                                            if (!isOpen) {
                                                              textEditingController.clear();
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 20.0),
                                            // Column(
                                            //   mainAxisAlignment: MainAxisAlignment.center,
                                            //   mainAxisSize: MainAxisSize.min,
                                            //   children: <Widget>[
                                            //     Padding(
                                            //       padding: const EdgeInsets.all(8.0),
                                            //       child: FlutterGooglePlacesWeb(apiKey: APIList.mapGoogleApiKey!, required: true, controller: parcel.customerAddressController,),
                                            //     ),
                                            //   ],
                                            // ),
                                            // Padding(
                                            //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                            //   child: AppTextField(
                                            //
                                            //     onChanged: (value) {
                                            //       setState(() {
                                            //         parcel.customerAddress = parcel.customerAddressController.text;
                                            //       });
                                            //     },
                                            //     // controller: parcel.pickupAddressController,
                                            //     controller: parcel.customerAddressController..text = parcel.customerAddress.toString()..selection = TextSelection.collapsed(offset: parcel.customerAddressController.text.length),
                                            //     validator: (value) {
                                            //       if (parcel.customerAddressController.text.isEmpty) {
                                            //         return "this_field_can_t_be_empty".tr;
                                            //       }
                                            //       return null;
                                            //     },
                                            //     cursorColor: kTitleColor,
                                            //     textFieldType: TextFieldType.NAME,
                                            //     decoration: kInputDecoration.copyWith(
                                            //         enabledBorder: const OutlineInputBorder(
                                            //           borderRadius: BorderRadius.all(Radius.circular(2.0)),
                                            //           borderSide: BorderSide(color: kBorderColorTextField, width: 2),
                                            //         ),
                                            //         labelText: 'Customer Address'.tr,
                                            //         labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                            //         hintText: 'enter_address'.tr,
                                            //         hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                                            //         suffixIcon: InkWell(
                                            //             onTap: () {
                                            //               Get.to(CustomerMapsScreen());
                                            //             },
                                            //             child: Icon(Icons.location_on))
                                            //     ),
                                            //   ),
                                            // ),

                                            // const SizedBox(height: 20.0),

                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20.0),
                                    Container(
                                      width: double.infinity,
                                      child: Card(
                                        color: Colors.white,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 15.0,top: 15.0),
                                              child: Text("Parcel Details :",style: TextStyle(fontWeight: FontWeight.bold)),
                                            ),
                                            Divider(),







                                            // const SizedBox(height: 20.0),
                                            //
                                            // AppTextField(
                                            //   controller: parcel.sellingPriceController,
                                            //   cursorColor: kTitleColor,
                                            //   textFieldType: TextFieldType.NAME,
                                            //   decoration: kInputDecoration.copyWith(
                                            //     enabledBorder: const OutlineInputBorder(
                                            //       borderRadius: BorderRadius.all(Radius.circular(2.0)),
                                            //       borderSide: BorderSide(color: kBorderColorTextField, width: 2),
                                            //     ),
                                            //     labelText: 'selling_price'.tr,
                                            //     labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                            //     hintText: 'selling_price_of_parcel'.tr,
                                            //     hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                                            //   ),
                                            // ),
                                            const SizedBox(height: 20.0),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                              child: SizedBox(
                                                height: 60.0,
                                                child: FormField(
                                                  builder: (FormFieldState<dynamic> field) {
                                                    return InputDecorator(
                                                      decoration: kInputDecoration.copyWith(
                                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                                        labelText: 'select_type'.tr + '*',
                                                        hintText: 'delivery_type'.tr,
                                                        labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                                        border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(5.0),
                                                        ),
                                                      ),
                                                      child: DropdownButtonHideUnderline(
                                                        child: selectType(),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 20.0),
                                            parcel.deliveryCategoryList.isEmpty
                                                ? SizedBox()
                                                : Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                  child: SizedBox(
                                                    height: 60.0,
                                                    child: FormField(
                                                    builder: (FormFieldState<dynamic> field) {
                                                    return InputDecorator(
                                                      decoration: kInputDecoration.copyWith(
                                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                                        labelText: 'category'.tr + '*',
                                                        hintText: 'Select Vehicle Type'.tr,
                                                        labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                                        border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(5.0),
                                                        ),
                                                      ),
                                                      child: DropdownButtonHideUnderline(
                                                        child: DropdownButton<DeliveryCategory>(
                                                          value: parcel.deliveryCategoryIndex.toString() == 'null' ? null : parcel.deliveryCategoryList[parcel.deliveryCategoryIndex],
                                                          items: parcel.deliveryCategoryList.map((DeliveryCategory value) {
                                                            return new DropdownMenuItem<DeliveryCategory>(

                                                              value: value,
                                                              child:  Text(value.title.toString() ),
                                                              // + ' (${value.weight.toString()})'
                                                            );
                                                          }).toList(),
                                                          onChanged: (newValue) {
                                                            setState(() {
                                                              parcel.deliveryCategoryIndex = parcel.deliveryCategoryList.indexOf(newValue!);
                                                              parcel.deliveryCategoryID = newValue.id.toString();
                                                              parcel.deliveryCategorysValue = newValue;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                                                                ),
                                                                                              ),
                                                ),

                                            const SizedBox(height: 20.0),



                                            // parcel.deliveryChargesList.isEmpty
                                            //     ? SizedBox()
                                            //     : SizedBox(
                                            //   height: 60.0,
                                            //   child: FormField(
                                            //     builder: (FormFieldState<dynamic> field) {
                                            //       return InputDecorator(
                                            //         decoration: kInputDecoration.copyWith(
                                            //           floatingLabelBehavior: FloatingLabelBehavior.always,
                                            //           labelText: 'category'.tr + '*',
                                            //           hintText: 'select_category'.tr,
                                            //           labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                            //           border: OutlineInputBorder(
                                            //             borderRadius: BorderRadius.circular(5.0),
                                            //           ),
                                            //         ),
                                            //
                                            //         child: DropdownButtonHideUnderline(
                                            //           child: DropdownButton<DeliveryCharge>(
                                            //             value: parcel.deliveryChargesList.toString() == 'null' ? null : parcel.deliveryChargesList[parcel.deliveryChargesIndex],
                                            //             items: parcel.deliveryChargesList.map((DeliveryCharge value) {
                                            //               print("object=value ${value.category}");
                                            //               return new DropdownMenuItem<DeliveryCharge>(
                                            //
                                            //                 value: value,
                                            //                 child: value.id == 0
                                            //                     ? Text(value.category.toString())
                                            //                     : value.category == '0'
                                            //                     ? Text(value.category.toString())
                                            //                     : Text(value.category.toString() ),
                                            //                 // + ' (${value.weight.toString()})'
                                            //               );
                                            //             }).toList(),
                                            //             onChanged: (newValue) {
                                            //               setState(() {
                                            //                 parcel.deliveryChargesIndex = parcel.deliveryChargesList.indexOf(newValue!);
                                            //                 parcel.deliveryChargesID = newValue.id.toString();
                                            //                 parcel.deliveryChargesValue = newValue;
                                            //               });
                                            //             },
                                            //           ),
                                            //         ),
                                            //       );
                                            //     },
                                            //   ),
                                            // ),

                                            // const SizedBox(height: 20.0),

                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                              child: AppTextField(
                                                controller: parcel.invoiceController,
                                                cursorColor: kTitleColor,
                                                isValidationRequired: false,
                                                textFieldType: TextFieldType.NAME,
                                                decoration: kInputDecoration.copyWith(
                                                  enabledBorder: const OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(2.0)),
                                                    borderSide: BorderSide(color: kBorderColorTextField, width: 2),
                                                  ),
                                                  labelText: 'invoice'.tr + '#',
                                                  labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                                  hintText: 'enter_invoice_number'.tr,
                                                  hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                                                ),
                                              ),
                                            ),

                                            SizedBox(height: 20.0),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                              child: TextFormField(
                                                controller: parcel.noteController,
                                                cursorColor: kTitleColor,
                                                textAlign: TextAlign.start,
                                                decoration: kInputDecoration.copyWith(
                                                  labelText: 'note'.tr,
                                                  labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                                  contentPadding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10.0),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 20.0),
                                            is_check==true? Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                              child: TextFormField(
                                                readOnly: true,
                                                onTap: () {
                                                  parcel.elivery_time_selectDateFromPicker(context);
                                                },
                                                controller: parcel.delivery_timeController.value,
                                                cursorColor: kTitleColor,
                                                textAlign: TextAlign.start,
                                                decoration: kInputDecoration.copyWith(
                                                  labelText: 'Delivery Date'.tr,
                                                  labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                                  contentPadding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10.0),
                                                  suffixIcon: IconButton(onPressed: () {
                                                    parcel.elivery_time_selectDateFromPicker(context);
                                                  }, icon: Icon(Icons.calendar_today_outlined),),
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Date Required".tr;
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ):SizedBox(),
                                            const SizedBox(height: 20.0),
                                            // parcel.googleMapsBlockList.isEmpty
                                            //     ? SizedBox()
                                            //     : Padding(
                                            //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                            //   child: SizedBox(
                                            //     height: 60.0,
                                            //     child: FormField(
                                            //       builder: (FormFieldState<dynamic> field) {
                                            //         return InputDecorator(
                                            //
                                            //           decoration: kInputDecoration.copyWith(
                                            //             floatingLabelBehavior: FloatingLabelBehavior.always,
                                            //             labelText: 'Block'.tr + '*',
                                            //             hintText: 'Select Block Number'.tr,
                                            //             labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                            //             border: OutlineInputBorder(
                                            //               borderRadius: BorderRadius.circular(5.0),
                                            //             ),
                                            //           ),
                                            //           child: DropdownButtonHideUnderline(
                                            //
                                            //             child: DropdownButton<GoogleMapsBlock>(
                                            //
                                            //               value: parcel.googleMapsBlockIndex.toString() == 'null' ? null : parcel.googleMapsBlockList[parcel.googleMapsBlockIndex],
                                            //               items: parcel.googleMapsBlockList.map((GoogleMapsBlock value) {
                                            //                 return new DropdownMenuItem<GoogleMapsBlock>(
                                            //                   value: value,
                                            //                   child: value.id == 0
                                            //                       ? Text("${value.blockName.toString()}")
                                            //                       : value.blockName == ''
                                            //                       ? Text("${value.blockNumber.toString()} ${value.blockName.toString()}")
                                            //                       : Text("${value.blockNumber.toString()} ${value.blockName.toString()}"),
                                            //                 );
                                            //               }).toList(),
                                            //               onChanged: (newValue) {
                                            //                 setState(() {
                                            //                   parcel.googleMapsBlockIndex = parcel.googleMapsBlockList.indexOf(newValue!);
                                            //                   parcel.customerAddress = newValue.googleMapsPlusCode.toString();
                                            //                   // parcel.customer_Lat = newValue.latitude ? newValue.latitude : 0;
                                            //                   // parcel.customer_Long = newValue.longitude? newValue.longitude : 0;
                                            //                   parcel.distanceMatrixServiceLatLong();
                                            //                 });
                                            //               },
                                            //             ),
                                            //           ),
                                            //         );
                                            //       },
                                            //     ),
                                            //   ),
                                            // ),


                                          ],
                                        ),
                                      ),
                                    ),



                                    // const SizedBox(height: 20.0),
                                    // Text(
                                    //   'choose_which_needed_for_parcel'.tr,
                                    //   style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold, fontSize: 18.0),
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     Checkbox(
                                    //       activeColor: kMainColor,
                                    //       shape: RoundedRectangleBorder(
                                    //         borderRadius: BorderRadius.circular(2.0),
                                    //       ),
                                    //       value: parcel.isLiquidChecked,
                                    //       onChanged: (val) {
                                    //         setState(
                                    //           () {
                                    //             parcel.isLiquidChecked = val!;
                                    //           },
                                    //         );
                                    //       },
                                    //     ),
                                    //     Text(
                                    //       'liquid_fragile'.tr,
                                    //       style: kTextStyle.copyWith(color: kTitleColor),
                                    //     ),
                                    //   ],
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     Checkbox(
                                    //       activeColor: kMainColor,
                                    //       shape: RoundedRectangleBorder(
                                    //         borderRadius: BorderRadius.circular(2.0),
                                    //       ),
                                    //       value: parcel.isParcelBankCheck,
                                    //       onChanged: (val) {
                                    //         setState(
                                    //           () {
                                    //             parcel.isParcelBankCheck = val!;
                                    //           },
                                    //         );
                                    //       },
                                    //     ),
                                    //     Text(
                                    //       'is_it_parcel_bank'.tr + '?',
                                    //       style: kTextStyle.copyWith(color: kTitleColor),
                                    //     ),
                                    //   ],
                                    // ),
                                    // const SizedBox(height: 20.0),
                                    // parcel.packagingList.isEmpty
                                    //     ? SizedBox()
                                    //     : SizedBox(
                                    //         height: 60.0,
                                    //         child: FormField(
                                    //           builder: (FormFieldState<dynamic> field) {
                                    //             return InputDecorator(
                                    //               decoration: kInputDecoration.copyWith(
                                    //                 floatingLabelBehavior: FloatingLabelBehavior.always,
                                    //                 labelText: 'packaging'.tr,
                                    //                 hintText: 'select_packaging'.tr,
                                    //                 labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                    //                 border: OutlineInputBorder(
                                    //                   borderRadius: BorderRadius.circular(5.0),
                                    //                 ),
                                    //               ),
                                    //               child: DropdownButtonHideUnderline(
                                    //                 child: DropdownButton<Packagings>(
                                    //                   value: parcel.packagingIndex.toString() == 'null' ? null : parcel.packagingList[parcel.packagingIndex],
                                    //                   items: parcel.packagingList.map((Packagings value) {
                                    //                     return new DropdownMenuItem<Packagings>(
                                    //                       value: value,
                                    //                       child: value.id == 0 ? Text(value.name.toString()) : Text(value.name.toString() + ' (${value.price.toString()})'),
                                    //                     );
                                    //                   }).toList(),
                                    //                   onChanged: (newValue) {
                                    //                     setState(() {
                                    //                       parcel.packagingIndex = parcel.packagingList.indexOf(newValue!);
                                    //                       parcel.packagingID = newValue.id.toString();
                                    //                       parcel.packagingPrice = newValue.price.toString();
                                    //                     });
                                    //                   },
                                    //                 ),
                                    //               ),
                                    //             );
                                    //           },
                                    //         ),
                                    //       ),
                                    const SizedBox(height: 20.0),


                                    const SizedBox(height: 20.0),
                                    ButtonGlobal(
                                        buttontext: 'submit'.tr,
                                        buttonDecoration: kButtonDecoration,
                                        onPressed: () {

                                          setState(() {
                                            FocusScope.of(context).requestFocus(new FocusNode());
                                            if (_formKey.currentState!.validate()) {
                                              if (parcel.deliveryCategoryID != '' || parcel.deliveryTypID != '') {
                                                is_check==true? parcel.calculateTotal(context) :
                                                Get.rawSnackbar(message: 'Check your pickup information & click check box');
                                              }

                                              else if (parcel.deliveryCategoryID == '') {
                                                Get.rawSnackbar(message: "Please select category", backgroundColor: Colors.red, snackPosition: SnackPosition.TOP);
                                              }

                                              else if (parcel.deliveryTypID == '') {
                                                Get.rawSnackbar(message: "Please select delivery type", backgroundColor: Colors.red, snackPosition: SnackPosition.TOP);
                                              } else {
                                                Get.rawSnackbar(message: "Please check information", backgroundColor: Colors.red, snackPosition: SnackPosition.TOP);
                                              }
                                            }
                                          });
                                        }
                                    ),

                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  parcel.loaderParcel
                      ? Positioned(
                    child: Container(height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width, color: Colors.white60, child: const Center(child: LoaderCircle())),
                  )
                      : const SizedBox.shrink(),
                ]))
    );
  }
}


// class DropDownSearch extends StatefulWidget {
//   const DropDownSearch({
//     super.key,
//     required this.title,
//     required this.textController,
//     required this.items,
//   });
//   final String title;
//   final TextEditingController? textController;
//   final List<String>? items;
//
//   @override
//   State<DropDownSearch> createState() => _DropDownSearchState();
// }
//
// class _DropDownSearchState extends State<DropDownSearch> {
//   bool _isTapped = false;
//   List<String> _filteredList = [];
//   List<String> _subFilteredList = [];
//
//   @override
//   initState() {
//     _filteredList = widget.items!;
//     _subFilteredList = _filteredList;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             widget.title,
//             style: const TextStyle(fontSize: 16, color: Color(0xFF858597)),
//           ),
//           const SizedBox(height: 5),
//           Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Column(
//                 children: [
//                   TextFormField(
//                     controller: widget.textController,
//                     onChanged: (val) {
//                       setState(() {
//                         _filteredList = _subFilteredList
//                             .where((element) => element.toLowerCase().contains(
//                             widget.textController!.text.toLowerCase()))
//                             .toList();
//                       });
//                     },
//                     validator: (val) =>
//                     val!.isEmpty ? 'Field can\'t empty' : null,
//                     style:
//                     TextStyle(color: Colors.black, fontSize: 16.0),
//                     onTap: () => setState(() => _isTapped = true),
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: Colors.white,
//                       errorStyle: const TextStyle(fontSize: 0.01),
//                       errorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: const BorderSide(
//                           color: Colors.black,
//                           style: BorderStyle.solid,
//                         ),
//                       ),
//                       contentPadding:
//                       const EdgeInsets.only(bottom: 10, left: 10),
//                       focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(
//                               color: Colors.black.withOpacity(0.7),
//                               width: 0.8)),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(
//                               color: Colors.black.withOpacity(0.7),
//                               width: 0.8)),
//                       labelStyle: const TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(
//                             color: Colors.black.withOpacity(0.7), width: 0.8),
//                       ),
//                       suffixIcon: Icon(Icons.arrow_drop_down, size: 25),
//                       isDense: true,
//                     ),
//                   ),
//                   _isTapped && _filteredList.isNotEmpty
//                       ? Container(
//                     height: 150.0,
//                     color: Colors.grey.shade200,
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: ListView.builder(
//                       itemCount: _filteredList.length,
//                       itemBuilder: (context, index) {
//                         return InkWell(
//                           onTap: () {
//                             setState(() => _isTapped = !_isTapped);
//                             widget.textController!.text =
//                             _filteredList[index];
//                             setState(() {
//
//                             });
//                           },
//                           child: Padding(
//                             padding:
//                             const EdgeInsets.symmetric(vertical: 8.0),
//                             child: Text(_filteredList[index],
//                                 style: TextStyle(
//                                     color: Colors.grey.shade800,
//                                     fontSize: 16.0)),
//                           ),
//                         );
//                       },
//                     ),
//                   )
//                       : const SizedBox.shrink(),
//                 ],
//               ))
//         ]);
//   }
// }