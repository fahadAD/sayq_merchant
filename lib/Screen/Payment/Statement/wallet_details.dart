 import '../../../Controllers/global-controller.dart';
import '../../../Models/completed_delivery_model.dart';
import '../../Widgets/constant.dart';
import '/Controllers/balance_controller.dart';
import '/Screen/Widgets/shimmer/deliveryCharge_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletDetails extends StatefulWidget {
  const WalletDetails({Key? key}) : super(key: key);

  @override
  State<WalletDetails> createState() => _WalletDetailsState();
}

class _WalletDetailsState extends State<WalletDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      appBar: AppBar(
        title: Text(
          'Wallet Details'.tr,
          style: kTextStyle.copyWith(color: kBgColor,fontWeight: FontWeight.w600),
        ),
        backgroundColor: kMainColor,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: kBgColor),
      ),
      body: GetBuilder<BalanceController>(
          init: BalanceController(),
          builder: (balanceController) {

            return Container(
                padding: const EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                height: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0.0),
                    topRight: Radius.circular(0.0),
                  ),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Container(
                    child: balanceController.loader? DeliveryChargeShimmer() : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10,),
                              Container(
                                height: 70,
                                width: double.infinity,
                                child: Card(
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          Text("Wallet Balance :",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17)),
                                          SizedBox(width: 5,),
                                          Text("${Get.find<GlobalController>().currency}${balanceController.balanceDetails.wallet_balance}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Align(
                              //     alignment: Alignment.topLeft,
                              //     child: Text("Balance",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color:kMainColor ))),
                              //   Container(
                              //     height: 100,
                              //      width: double.infinity,
                              //     child: Card(
                              //       color: Colors.white,
                              //       child: Row(
                              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //         children: [
                              //           Row(
                              //             children: [
                              //                SizedBox(width: 20,),
                              //                Text("90.0 ${Get.find<GlobalController>().currency}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                              //                SizedBox(width: 5,),
                              //                Icon(Icons.more_rounded)
                              //             ],
                              //           ),
                              //           Padding(
                              //             padding: const EdgeInsets.only(right: 15.0),
                              //             child: Column(
                              //               crossAxisAlignment: CrossAxisAlignment.center,
                              //               mainAxisAlignment: MainAxisAlignment.center,
                              //               children: [
                              //               Row(
                              //                 children: [
                              //                   Icon(Icons.add),
                              //                   SizedBox(width: 10,),
                              //                   Text("Top-up"),
                              //
                              //                 ],
                              //               ),
                              //               SizedBox(height: 10,),
                              //               Row(
                              //                 children: [
                              //                   Icon(Icons.account_balance),
                              //                   SizedBox(width: 10,),
                              //                   Text("Withdraw"),
                              //
                              //                 ],
                              //               ),
                              //
                              //               ],
                              //             ),
                              //           ),
                              //
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              //   SizedBox(height: 10,),
                              //   Align(
                              //       alignment: Alignment.topLeft,
                              //       child: Text("Overdraft Limit",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color:kMainColor ))),
                              //   Container(
                              //     height: 70,
                              //     width: double.infinity,
                              //     child: Card(
                              //       color: Colors.white,
                              //       child: Row(
                              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //         children: [
                              //           Row(
                              //             children: [
                              //               SizedBox(width: 20,),
                              //               Text("90.0 ${Get.find<GlobalController>().currency}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                              //
                              //             ],
                              //           ),
                              //           Padding(
                              //             padding: const EdgeInsets.only(right: 15.0),
                              //             child: Row(
                              //               children: [
                              //                 Icon(Icons.insert_comment),
                              //                 SizedBox(width: 10,),
                              //                 Text("Request Limit Increase"),
                              //
                              //               ],
                              //             ),
                              //           ),
                              //
                              //         ],
                              //       ),
                              //     ),
                              //   ),

                              SizedBox(height: 20,),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Transaction",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color:kMainColor ))),
                              SizedBox(height: 10,),

                              balanceController.parcelList.isEmpty? Padding(
                                padding: const EdgeInsets.only(top: 100.0),
                                child: Center(child: Text("No Transaction Data")),
                              ) : Container(
                                width: double.infinity,
                                child: Card(
                                  color: Colors.white,
                                  child:   ListView.builder(
                                    itemCount: balanceController.parcelList.length,
                                    primary: false,
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext context, int index) {
                                      return InkWell(

                                        onTap: () {
                                          Get.to(()=>WalletDetailsScreen(data: balanceController.parcelList[index]));
                                        },
                                        child: Column(

                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 6.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      text: '',
                                                      style: TextStyle(color: Colors.black),
                                                      children:   <TextSpan>[
                                                        TextSpan(text: '#${balanceController.parcelList[index].trackingId}', style: TextStyle(fontWeight: FontWeight.w600,)),
                                                        TextSpan(text: '  ', style: TextStyle(fontWeight: FontWeight.w600)),
                                                      ],
                                                    ),
                                                  ),

                                                  Text("Success",style: TextStyle(fontWeight: FontWeight.w600,color: kMainColor),)
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 6.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      text: '',
                                                      style: TextStyle(color: Colors.black),
                                                      children:   <TextSpan>[
                                                        TextSpan(text: '${balanceController.parcelList[index].updatedAt}', style: TextStyle(fontWeight: FontWeight.normal,)),
                                                       ],
                                                    ),
                                                  ),

                                                  Text("${balanceController.parcelList[index].totalDeliveryAmount} ${Get.find<GlobalController>().currency}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 12.0,),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      text: 'COD Amount ',
                                                      style: TextStyle(color: Colors.black,fontSize: 14),
                                                      children:   <TextSpan>[
                                                        TextSpan(text: '${balanceController.parcelList[index].cashCollection} ${Get.find<GlobalController>().currency}', style: TextStyle(fontWeight: FontWeight.normal,)),

                                                      ],
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),
                                            Divider(),
                                            SizedBox(height: 5,)
                                          ],),
                                      );
                                    },

                                  ),
                                ),
                              ),

                            ],),
                        )
                      ],
                    ),
                  ),
                )
            );
          }
      ),
    );
  }
}

class WalletDetailsScreen extends StatefulWidget {
    WalletDetailsScreen({super.key, required this.data});
   final CompletedDelivery data;

  @override
  State<WalletDetailsScreen> createState() => _WalletDetailsScreenState();
}

class _WalletDetailsScreenState extends State<WalletDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: kMainColor,
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          'Wallet Details'.tr,
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
      body: GetBuilder<BalanceController>(
          init: BalanceController(),
          builder: (balanceController) =>
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
                                            'invoice'.tr+': #${widget.data.invoiceNO}',
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
                                            widget.data.statusName.toString(),
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
                                            .currency!}${(double.parse(widget.data.totalDeliveryAmount.toString()) - double.parse(widget.data.codAmount.toString())).toStringAsFixed(2)}',
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
                                            .currency!}${widget.data.codAmount}',
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
                                            .currency!}${widget.data.totalDeliveryAmount}',
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
                                        widget.data.deliveryType.toString(),
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
                                        widget.data.weight.toString(),
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
                                            .currency!}${widget.data.cashCollection}',
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
                                        widget.data.merchantName.toString(),
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
                                        widget.data.merchantMobile.toString(),
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
                                        widget.data.merchantUserEmail.toString(),
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
                                        widget.data.customerName.toString(),
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
                                        widget.data.customerPhone.toString(),
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
                                        widget.data.customerAddress.toString(),
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
                                        widget.data.trackingId.toString(),
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
                                        widget.data.deliveryType.toString(),
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
                                        widget.data.pickupDate.toString(),
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
                                        widget.data.deliveryDate.toString(),
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
                                            .currency!}${widget.data.totalDeliveryAmount}',
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
                                            .currency!}${widget.data.vatAmount}',
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
                                            .currency!}${widget.data.currentPayable}',
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
                                            .currency!}${widget.data.cashCollection}',
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
    );;
  }
}

