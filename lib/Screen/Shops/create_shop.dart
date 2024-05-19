 import 'package:dropdown_button2/dropdown_button2.dart';

import '../../Models/parcel_crate_model.dart';
import '/Screen/Widgets/button_global.dart';
import '/Screen/Widgets/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:get/get.dart';

import '../../Controllers/shop_controller.dart';
import '../../utils/size_config.dart';
import '../Widgets/loader.dart';

class CreateShops extends StatefulWidget {
  const CreateShops({Key? key}) : super(key: key);

  @override
  State<CreateShops> createState() => _CreateShopsState();
}

class _CreateShopsState extends State<CreateShops> {
  ShopController shopController = ShopController();
  final _formKey = GlobalKey<FormState>();
  String status = 'active'.tr;
  List<String> selectStatus = [
    'active'.tr,
    'inactive'.tr,
  ];

  DropdownButton<String> selectStatusDrop() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String des in selectStatus) {
      var item = DropdownMenuItem(
        value: des,
        child: Text(des),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      items: dropDownItems,
      value: status,
      onChanged: (value) {
        setState(() {
          status = value!;
        });
      },
    );
  }

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfigCustom sizeConfig = SizeConfigCustom();
    sizeConfig.init(context);
    return Scaffold(
      backgroundColor: kMainColor,
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          'Create Address'.tr,
          style: kTextStyle.copyWith(color: kBgColor),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: const Icon(FeatherIcons.x,color: kBgColor,).onTap(()=>finish(context))
          ),
        ],
        backgroundColor: kMainColor,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: kBgColor),
      ),
      body:
      GetBuilder<ShopController>(
    init: ShopController(),
    builder: (shop) =>
        Stack(children: [
        Center(
        child:
      SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30.0),
            Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(color: kGreyTextColor.withOpacity(0.2)),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child:
                Form(
                  key: _formKey,
                  child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20.0),
                    AppTextField(
                      showCursor: true,
                      controller: shop.nameController,
                      validator: (value) {
                        if (shop.nameController.text.isEmpty) {
                          return "this_field_can_t_be_empty".tr;
                        }
                        return null;
                      },
                      cursorColor: kTitleColor,
                      textFieldType: TextFieldType.NAME,
                      decoration: kInputDecoration.copyWith(
                        labelText: 'name'.tr+'*',
                        labelStyle: kTextStyle.copyWith(color: kTitleColor),
                        hintText: 'enter_name'.tr,
                        hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    AppTextField(
                      showCursor: true,
                      controller: shop.phoneController,
                      validator: (value) {
                        if (shop.phoneController.text.isEmpty) {
                          return "this_field_can_t_be_empty".tr;
                        }
                        return null;
                      },
                      cursorColor: kTitleColor,
                      textFieldType: TextFieldType.PHONE,
                      decoration: kInputDecoration.copyWith(
                        labelText: 'mobile'.tr+'*',
                        labelStyle: kTextStyle.copyWith(color: kTitleColor),
                        hintText: 'enter_phone_number'.tr,
                        hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: shop.addressController,
                      validator: (value) {
                        if (shop.addressController.text.isEmpty) {
                          return "this_field_can_t_be_empty";
                        }
                        return null;
                      },
                      cursorColor: kTitleColor,
                      textAlign: TextAlign.start,
                      decoration: kInputDecoration.copyWith(
                        labelText: 'address'.tr+'*',
                        labelStyle: kTextStyle.copyWith(color: kTitleColor),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 40, horizontal: 10.0),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 60.0,
                      child: FormField(
                        builder: (FormFieldState<dynamic> field) {
                          return InputDecorator(
                            decoration: kInputDecoration.copyWith(
                              floatingLabelBehavior:
                              FloatingLabelBehavior.always,
                              labelText: 'status'.tr+'*',
                              hintText: 'select_status'.tr,
                              labelStyle:
                              kTextStyle.copyWith(color: kTitleColor),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: selectStatusDrop(),
                            ),
                          );
                        },
                      ),
                    ),
                    // const SizedBox(height: 20),
                    //
                    // shop.googleMapsBlockList.isEmpty
                    //     ? SizedBox()
                    //     :
                    // SizedBox(
                    //   height: 60.0,
                    //   child: FormField(
                    //     builder: (FormFieldState<dynamic> field) {
                    //       return InputDecorator(
                    //         decoration: kInputDecoration.copyWith(
                    //           floatingLabelBehavior: FloatingLabelBehavior.always,
                    //           labelText: 'Block'.tr + '*',
                    //           hintText: 'Select Block Number'.tr,
                    //           labelStyle: kTextStyle.copyWith(color: kTitleColor),
                    //           border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(5.0),
                    //           ),
                    //         ),
                    //         child: DropdownButtonHideUnderline(
                    //
                    //           child: DropdownButton<GoogleMapsBlock>(
                    //
                    //             value: shop.googleMapsBlockIndex.toString() == 'null' ? null : shop.googleMapsBlockList[shop.googleMapsBlockIndex],
                    //             items: shop.googleMapsBlockList.map((GoogleMapsBlock value) {
                    //               return new DropdownMenuItem<GoogleMapsBlock>(
                    //                 value: value,
                    //                 child: value.id == 0
                    //                     ? Text("${value.blockName.toString()}")
                    //                     : value.blockName == ''
                    //                     ? Text("${value.blockNumber.toString()} ${value.blockName.toString()}")
                    //                     : Text("${value.blockNumber.toString()} ${value.blockName.toString()}"),
                    //               );
                    //             }).toList(),
                    //             onChanged: (newValue) {
                    //               setState(() {
                    //                 shop.googleMapsBlockIndex = shop.googleMapsBlockList.indexOf(newValue!);
                    //                 shop.deliveryCategoryID = newValue.googleMapsPlusCode.toString();
                    //                 shop.deliveryCategorysValue = newValue;
                    //
                    //               });
                    //             },
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),

                    const SizedBox(height: 20),
                    shop.googleMapsBlockList.isEmpty
                        ? SizedBox()
                        :
                    SizedBox(
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
                                value: shop.googleMapsBlockIndex.toString() == 'null' ? null : shop.googleMapsBlockList[shop.googleMapsBlockIndex],
                                items: shop.googleMapsBlockList.map((GoogleMapsBlock value) {
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
                                    shop.googleMapsBlockIndex = shop.googleMapsBlockList.indexOf(newValue!);
                                    shop.deliveryCategoryID = newValue.googleMapsPlusCode.toString();
                                    shop.deliveryCategorysValue = newValue;

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
                                  searchMatchFn: ( item, searchValue) {

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


                    const SizedBox(height: 30.0),
                   ButtonGlobal(buttontext: 'submit'.tr, buttonDecoration: kButtonDecoration, onPressed: () {
                     if (_formKey.currentState!.validate()) {
                       shop.shopPost(status);
                     }

                   })
                  ],
                )),
              ),
            ),
          ],
        ),
      )),
    shop.loader
    ? Positioned(
    child: Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    color: Colors.white60,
    child: const Center(child: LoaderCircle())),
    )
        : const SizedBox.shrink(),
    ])
    ));
  }
}
