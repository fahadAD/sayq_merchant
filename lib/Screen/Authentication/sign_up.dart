
import 'package:dropdown_button2/dropdown_button2.dart';
 import '../../Controllers/auth-controller.dart';
import '../../Models/googleMapsPlusCode.dart';
import '../MapScreen/map.dart';
import '/Controllers/global-controller.dart';
import '/Screen/Authentication/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../utils/image.dart';
import '../../utils/size_config.dart';
import '../Widgets/button_global.dart';
import '../Widgets/constant.dart';
import 'package:get/get.dart';
import '../Widgets/loader.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool isChecked = true;
  final _formKey = GlobalKey<FormState>();
  int hub = 1;

  GlobalController globalController = Get.put(GlobalController());
  AuthController authController = Get.put(AuthController());
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
  authController.getBlockList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfigCustom sizeConfig = SizeConfigCustom();
    sizeConfig.init(context);

print('object${authController.blockHistory.length}');
    return Scaffold(
      backgroundColor: kMainColor,
      body: GetBuilder<AuthController>(
    init: AuthController(),
    builder: (auth) =>
        Stack(children: [
        Center(
        child:
      SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
              margin: EdgeInsets.only(right: 0),
              height: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Images.appLogo),
                  fit: BoxFit.contain,
                ),
              ),
            ),

            Text(
              'registration_form'.tr,
              style: kTextStyle.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
            const SizedBox(height: 5.0),
            Text(
              'please_enter_your_user_information'.tr,
              style: kTextStyle.copyWith(color: Colors.white),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child:
                Form(
                  key: _formKey,
                  child:
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 20),
                          AppTextField(
                            showCursor: true,
                            controller: auth.businessNameController,
                            validator: (value) {
                              if (auth.businessNameController.text.isEmpty) {
                                return "this_field_can_t_be_empty".tr;
                              }
                              return null;
                            },
                            cursorColor: kTitleColor,
                            textFieldType: TextFieldType.NAME,
                            decoration: kInputDecoration.copyWith(
                              labelText: 'business_name'.tr,
                              labelStyle: kTextStyle.copyWith(color: kTitleColor),
                              hintText: 'wecourier'.tr,
                              hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                            ),
                          ),
                          const SizedBox(height: 20),
                          AppTextField(
                            showCursor: true,
                            controller: auth.firstNameController,
                            validator: (value) {
                              if (auth.firstNameController.text.isEmpty) {
                                return "this_field_can_t_be_empty".tr;
                              }
                              return null;
                            },
                            cursorColor: kTitleColor,
                            textFieldType: TextFieldType.NAME,
                            decoration: kInputDecoration.copyWith(
                              labelText: 'first_name'.tr,
                              labelStyle: kTextStyle.copyWith(color: kTitleColor),
                              hintText: 'we'.tr,
                              hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                            ),
                          ),
                          const SizedBox(height: 20),
                          AppTextField(
                            showCursor: true,
                            controller: auth.lastNameController,
                            validator: (value) {
                              if (auth.lastNameController.text.isEmpty) {
                                return "this_field_can_t_be_empty".tr;
                              }
                              return null;
                            },
                            cursorColor: kTitleColor,
                            textFieldType: TextFieldType.NAME,
                            decoration: kInputDecoration.copyWith(
                              labelText: 'last_name'.tr,
                              labelStyle: kTextStyle.copyWith(color: kTitleColor),
                              hintText: 'courier'.tr,
                              hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                            ),
                          ),
                          const SizedBox(height: 20),
                          auth.blockHistory.isEmpty
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
                                    child: DropdownButton2<GoogleMapsPlusCodeList>(
                                      iconStyleData: IconStyleData(icon: Icon(Icons.search_outlined)),
                                      hint: Text(
                                        'Select Item',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),

                                      value: auth.googleMapsBlockIndex.toString() == 'null' ? null : auth.blockHistory[auth.googleMapsBlockIndex],
                                      items: auth.blockHistory.map((GoogleMapsPlusCodeList value) {
                                        return new DropdownMenuItem<GoogleMapsPlusCodeList>(
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
                                          auth.googleMapsBlockIndex = auth.blockHistory.indexOf(newValue!);
                                          auth.blockCategoryID = newValue.googleMapsPlusCode.toString();
                                          auth.blockCategorysValue = newValue;

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


                          const SizedBox(height: 20),


                          AppTextField(
                            onChanged: (value) {
                              setState(() {
                                auth.pickupAddress.value =auth.addressController.text;
                              });
                            },
                            // controller: parcel.pickupAddressController,
                            controller: auth.addressController..text = auth.pickupAddress.value.toString()..selection = TextSelection.collapsed(offset: auth.addressController.text.length),
                            validator: (value) {
                              if (auth.addressController.text.isEmpty) {
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
                                labelText: 'address'.tr,
                                labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                hintText: 'enter_address'.tr,
                                hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                                suffixIcon: InkWell(
                                    onTap: () {
                                      Get.to(()=>MapsScreenOne());
                                    },
                                    child: Icon(Icons.location_on))
                            ),
                          ),


                          const SizedBox(height: 20),
                          Obx(() => InkWell(
                            onTap: () {
                              Get.to(()=>MapsScreenOne());
                            },
                            child: Container(
                              height: 70,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border.all(color: kBorderColorTextField)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          height: 50,
                                          width: 290,
                                          child: Text(
                                              "${auth.pickupAddress.value}"),
                                        )),
                                  ),
                                  Icon(Icons.location_on_outlined)
                                ],
                              ),
                            ),
                          )),

                          const SizedBox(height: 20),

                          // globalController.hubList.isNotEmpty ?
                          // SizedBox(
                          //   height: 60.0,
                          //   child: FormField(
                          //     builder: (FormFieldState<dynamic> field) {
                          //       return InputDecorator(
                          //         decoration: kInputDecoration.copyWith(
                          //           floatingLabelBehavior: FloatingLabelBehavior.always,
                          //           labelText: 'hub'.tr,
                          //           hintText: 'select_hub'.tr,
                          //           labelStyle: kTextStyle.copyWith(color: kTitleColor),
                          //           border: OutlineInputBorder(
                          //             borderRadius: BorderRadius.circular(5.0),
                          //           ),
                          //         ),
                          //         child: DropdownButtonHideUnderline(
                          //           child:  DropdownButton<Hubs>(
                          //           items: globalController.dropDownItems,
                          //             value: globalController.hubList[globalController.hubList.indexWhere((i) => i.id == hub)],
                          //           onChanged: (value) {
                          //             setState(() {
                          //               hub = value!.id!;
                          //             });
                          //           },
                          //         )
                          //         ),
                          //       );
                          //     },
                          //   ),
                          // ): SizedBox(height: 0,),

                          DropDownWidget(
                              itemList: globalController.hubList.map((element) => element.name!).toList(),
                              selectedValue: '',
                              initialValue: 'HUB',
                              onChanged: (val) {
                                var hubs = globalController.hubList.firstWhere((element) => element.name == val);
                                setState(() {
                                  hub = hubs.id!;
                                });
                              }),

                          const SizedBox(height: 20),
                          AppTextField(
                            showCursor: true,
                            cursorColor: kTitleColor,
                            controller: auth.phoneController,
                            validator: (value) {
                              if (auth.phoneController.text.isEmpty) {
                                return "this_field_can_t_be_empty".tr;
                              }
                              return null;
                            },
                            textFieldType: TextFieldType.PHONE,
                            decoration: kInputDecoration.copyWith(
                              labelText: 'mobile'.tr,
                              labelStyle: kTextStyle.copyWith(color: kTitleColor),
                              hintText: '017XXXXXXXX',
                              hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                            ),
                          ),
                          const SizedBox(height: 20),
                          AppTextField(
                            showCursor: true,
                            cursorColor: kTitleColor,
                            controller: auth.passwordController,
                            validator: (value) {
                              if (auth.passwordController.text.isEmpty) {
                                return "this_field_can_t_be_empty".tr;
                              }
                              return null;
                            },
                            textFieldType: TextFieldType.PASSWORD,
                            decoration: kInputDecoration.copyWith(
                              labelText: 'password'.tr,
                              labelStyle: kTextStyle.copyWith(color: kTitleColor),
                              hintText: '********',
                              hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                activeColor: kMainColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                                value: isChecked,
                                onChanged: (val) {
                                  setState(
                                        () {
                                      isChecked = val!;
                                    },
                                  );
                                },
                              ),
                              Flexible(
                                child: RichText(
                                  text: TextSpan(
                                      text: 'i_agree_to'.tr,
                                      style: kTextStyle.copyWith(color: kTitleColor),
                                      children: [
                                        TextSpan(
                                          text: 'e_courier'.tr,
                                          style: kTextStyle.copyWith(
                                              color: kGreyTextColor),
                                        ),
                                        TextSpan(
                                          text: 'privacy_Policy_&_terms'.tr,
                                          style:
                                          kTextStyle.copyWith(color: kTitleColor),
                                        )
                                      ]),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 20.0),

                    SizedBox( height: 70,
                        child:
                          ButtonGlobal(
                              buttontext: 'register_my_account'.tr,
                              buttonDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: kMainColor),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  if(auth.blockCategoryID != ''){
                                    await auth.signupOnTap(hub);
                                  }else{
                                    Get.rawSnackbar(message: "Select Block Number",backgroundColor: Colors.red, snackPosition: SnackPosition.TOP);

                                  }

                                }

                              })),
                    Flexible(child:
                          RichText(
                            text: TextSpan(
                              text: 'already_member'.tr,
                              style: kTextStyle.copyWith(color: kGreyTextColor),
                              children: [
                                TextSpan(
                                  text: 'login_here'.tr,
                                  style: kTextStyle.copyWith(color: kMainColor),
                                ),
                              ],
                            ),
                          ).onTap(() => const SignIn().launch(context),
                          )),
                        ],
                      )),
              ),
            ),
          ],
        ),
      )),
          auth.loader
              ? Positioned(
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.white60,
                child: const Center(child: LoaderCircle())),
          )
              : const SizedBox.shrink(),
        ])
      ),

    );
  }
}







class DropDownWidget extends StatefulWidget {
  DropDownWidget({
    super.key,
    required this.itemList,
    required this.selectedValue,
    required this.initialValue,
    required this.onChanged,
  });

  final List<String> itemList;
  void Function(String?)? onChanged;
  String? selectedValue;
  final String? initialValue;

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      isExpanded: true,
      decoration: InputDecoration(
        // Add Horizontal padding using menuItemStyleData.padding so it matches
        // the menu padding when button's width is not specified.
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.black26),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.black26),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
          borderRadius: BorderRadius.circular(5),
        ),
        filled: true,
        fillColor: Colors.white,
        // Add more decoration..
      ),
      hint: Text(
        widget.initialValue!,
        style: const TextStyle(fontSize: 14),
      ),
      items: widget.itemList
          .map((item) => DropdownMenuItem<String>(
        value: item,
        child: Text(
          item,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select value.';
        }
        return null;
      },
      onChanged: widget.onChanged,
      onSaved: (value) {
        widget.selectedValue = value.toString();
      },
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      iconStyleData: const IconStyleData(
        icon: Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.keyboard_arrow_down_outlined,
              size: 28,
            )),
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}


