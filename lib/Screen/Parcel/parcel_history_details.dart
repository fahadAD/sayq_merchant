import '/Models/parcels_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../Controllers/global-controller.dart';
import '../../Controllers/parcel_controller.dart';
import '../Widgets/constant.dart';
import '../Widgets/shimmer/parcel_log_shimmer.dart';


class ParcelHistoryDetails extends StatefulWidget {
  final Parcels parcel;


  ParcelHistoryDetails({Key? key, required this.parcel, }) : super(key: key);

  @override
  State<ParcelHistoryDetails> createState() => _ParcelHistoryDetailsState();
}

class _ParcelHistoryDetailsState extends State<ParcelHistoryDetails> {

  int statusActive = 1;
  ParcelController parcelController = Get.put(ParcelController());
  @override
  void initState() {
    // parcelController.getParcelLogs(widget.id!);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          'Order History Details'.tr,
          style: kTextStyle.copyWith(color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),

        backgroundColor: kMainColor,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: GetBuilder<ParcelController>(
          init: ParcelController(),
          builder: (parcelLogs) =>
              Container(
                padding: const EdgeInsets.all(10.0),
                margin: EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  color: Colors.white,
                ),
                child:
                SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        SizedBox(height: 10),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.76,
                          child: SingleChildScrollView(
                            child:Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Card(
                                      elevation: 10,
                                      color: kSecondaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'invoice'.tr+': #${widget.parcel.invoiceNO}',
                                          style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Card(
                                      elevation: 10,
                                      color: kSecondaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          widget.parcel.statusName.toString(),
                                          style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  'cash_of_delivery'.tr,
                                  style: kTextStyle.copyWith(color: kTitleColor, fontSize: 18.0, fontWeight: FontWeight.bold),
                                ),
                                Divider(
                                  thickness: 1.0,
                                  color: kGreyTextColor.withOpacity(0.5),
                                ),
                                const SizedBox(height: 10.0),
                                Row(
                                  children: [
                                    Text(
                                      'delivery_fee'.tr + ':',
                                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '${Get.find<GlobalController>()
                                          .currency!}${(double.parse(widget.parcel.totalDeliveryAmount.toString()) - double.parse(widget.parcel.codAmount.toString())).toStringAsFixed(2)}',
                                      style: kTextStyle.copyWith(color: kGreyTextColor),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5.0),
                                Row(
                                  children: [
                                    Text(
                                      'cod'.tr + ':',
                                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '${Get.find<GlobalController>()
                                          .currency!}${widget.parcel.codAmount}',
                                      style: kTextStyle.copyWith(color: kGreyTextColor),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5.0),
                                Row(
                                  children: [
                                    Text(
                                      'total_cost'.tr + ':',
                                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '${Get.find<GlobalController>()
                                          .currency!}${widget.parcel.totalDeliveryAmount}',
                                      style: kTextStyle.copyWith(color: kGreyTextColor,fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  'delivery_info'.tr,
                                  style: kTextStyle.copyWith(color: kTitleColor, fontSize: 18.0, fontWeight: FontWeight.bold),
                                ),
                                Divider(
                                  thickness: 1.0,
                                  color: kGreyTextColor.withOpacity(0.5),
                                ),
                                const SizedBox(height: 10.0),
                                Row(
                                  children: [
                                    Text(
                                      'delivery_type'.tr + ':',
                                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Text(
                                      widget.parcel.deliveryType.toString(),
                                      style: kTextStyle.copyWith(color: kGreyTextColor),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5.0),
                                Row(
                                  children: [
                                    Text(
                                      'weight'.tr + ':',
                                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Text(
                                      widget.parcel.weight.toString(),
                                      style: kTextStyle.copyWith(color: kGreyTextColor),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5.0),
                                Row(
                                  children: [
                                    Text(
                                      'amount_to_collection'.tr + ':',
                                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '${Get.find<GlobalController>()
                                          .currency!}${widget.parcel.cashCollection}',
                                      style: kTextStyle.copyWith(color: kGreyTextColor,fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  'sender_info'.tr,
                                  style: kTextStyle.copyWith(color: kTitleColor, fontSize: 18.0, fontWeight: FontWeight.bold),
                                ),

                                Divider(
                                  thickness: 1.0,
                                  color: kGreyTextColor.withOpacity(0.5),
                                ),

                                const SizedBox(height: 10.0),
                                Row(
                                  children: [
                                    Text(
                                      'business_name'.tr + ':',
                                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Text(
                                      widget.parcel.merchantName.toString(),
                                      style: kTextStyle.copyWith(color: kGreyTextColor),
                                    ),

                                  ],
                                ),
                                const SizedBox(height: 5.0),
                                Row(
                                  children: [
                                    Text(
                                      'mobile'.tr + ':',
                                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Text(
                                      widget.parcel.merchantMobile.toString(),
                                      style: kTextStyle.copyWith(color: kGreyTextColor),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5.0),
                                Row(
                                  children: [
                                    Text(
                                      'email'.tr + ':',
                                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Text(
                                      widget.parcel.merchantUserEmail.toString(),
                                      style: kTextStyle.copyWith(color: kGreyTextColor,fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  'recipient_info'.tr,
                                  style: kTextStyle.copyWith(color: kTitleColor, fontSize: 18.0, fontWeight: FontWeight.bold),
                                ),
                                Divider(
                                  thickness: 1.0,
                                  color: kGreyTextColor.withOpacity(0.5),
                                ),
                                const SizedBox(height: 10.0),
                                Row(
                                  children: [
                                    Text(
                                      'name'.tr + ':',
                                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Text(
                                      widget.parcel.customerName.toString(),
                                      style: kTextStyle.copyWith(color: kGreyTextColor),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5.0),
                                Row(
                                  children: [
                                    Text(
                                      'phone'.tr + ':',
                                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Text(
                                      widget.parcel.customerPhone.toString(),
                                      style: kTextStyle.copyWith(color: kGreyTextColor),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5.0),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 70,
                                      child: Text(
                                        'address'.tr + ':',
                                        style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Flexible(child: Text(
                                      widget.parcel.customerAddress.toString(),
                                      style: kTextStyle.copyWith(color: kGreyTextColor,fontWeight: FontWeight.bold),
                                    )),
                                  ],
                                ),
                                const SizedBox(height: 30.0),
                                Text(
                                  'parcel_info'.tr,
                                  style: kTextStyle.copyWith(color: kTitleColor, fontSize: 18.0, fontWeight: FontWeight.bold),
                                ),
                                Divider(
                                  thickness: 1.0,
                                  color: kGreyTextColor.withOpacity(0.5),
                                ),
                                const SizedBox(height: 10.0),
                                Row(
                                  children: [
                                    Text(
                                      'tracking_id'.tr + ':',
                                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Text(
                                      widget.parcel.trackingId.toString(),
                                      style: kTextStyle.copyWith(color: Colors.blue),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5.0),
                                Row(
                                  children: [
                                    Text(
                                      'delivery_type'.tr + ':',
                                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Text(
                                      widget.parcel.deliveryType.toString(),
                                      style: kTextStyle.copyWith(color: kGreyTextColor),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5.0),
                                Row(
                                  children: [
                                    Text(
                                      'pickup_time'.tr + ':',
                                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Text(
                                      widget.parcel.pickupDate.toString(),
                                      style: kTextStyle.copyWith(color: kGreyTextColor),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5.0),
                                Row(
                                  children: [
                                    Text(
                                      'delivery_time'.tr + ':',
                                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Text(
                                      widget.parcel.deliveryDate.toString(),
                                      style: kTextStyle.copyWith(color: kGreyTextColor),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5.0),
                                Row(
                                  children: [
                                    Text(
                                      'total_charge_amount'.tr + ':',
                                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '${Get.find<GlobalController>()
                                          .currency!}${widget.parcel.totalDeliveryAmount}',
                                      style: kTextStyle.copyWith(color: kGreyTextColor),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5.0),
                                Row(
                                  children: [
                                    Text(
                                      'vat_amount'.tr + ':',
                                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '${Get.find<GlobalController>()
                                          .currency!}${widget.parcel.vatAmount}',
                                      style: kTextStyle.copyWith(color: kGreyTextColor),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5.0),
                                Row(
                                  children: [
                                    Text(
                                      'current_payable'.tr + ':',
                                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '${Get.find<GlobalController>()
                                          .currency!}${widget.parcel.currentPayable}',
                                      style: kTextStyle.copyWith(color: kGreyTextColor),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5.0),
                                Row(
                                  children: [
                                    Text(
                                      'cash_collection'.tr + ':',
                                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '${Get.find<GlobalController>()
                                          .currency!}${widget.parcel.cashCollection}',
                                      style: kTextStyle.copyWith(color: kGreyTextColor),
                                    ),
                                  ],
                                ),

                              ],
                            )

                          ),
                        ),
                        SizedBox(height: 50),
                      ]),
                ),
              )),
    );
  }
}
