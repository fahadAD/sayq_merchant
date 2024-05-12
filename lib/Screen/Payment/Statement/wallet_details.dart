 import '../../../Controllers/global-controller.dart';
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
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
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
                              Container(

                                width: double.infinity,
                                child: Card(
                                  color: Colors.white,
                                  child:   ListView.builder(
                                    itemCount: balanceController.parcelList.length,
                                    primary: false,
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Column(

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
                                        ],);
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
