import '../../Controllers/global-controller.dart';
import '/Controllers/balance_controller.dart';
import '/Screen/Parcel/clearable_parcel.dart';
import '/Screen/Payment/PaymentRequest/create_payment_request.dart';
import '/Screen/Widgets/button_global.dart';
import '/Screen/Widgets/shimmer/deliveryCharge_shimmer.dart';
import '/Screen/Widgets/shimmer/profile_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Widgets/constant.dart';

class BalanceDetails extends StatefulWidget {
  const BalanceDetails({Key? key}) : super(key: key);

  @override
  State<BalanceDetails> createState() => _BalanceDetailsState();
}

class _BalanceDetailsState extends State<BalanceDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      appBar: AppBar(
        title: Text(
          'Balance Details'.tr,
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

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                        decoration: BoxDecoration(
                          color: kBorderColorTextField,
                          borderRadius: BorderRadius.circular(10),
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text("Balance Details",style:TextStyle(fontSize: 17,color: kTitleColor,fontWeight: FontWeight.bold,)),
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Amount Delivered",style:TextStyle(fontSize: 15,color: kTitleColor,fontWeight: FontWeight.w500,)),
                                Text("${balanceController.balanceDetails.amountDelivered!.toStringAsFixed(2)}",style:TextStyle(fontSize: 15,color: kTitleColor,fontWeight: FontWeight.w500,)),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Payable Delivery Charge",style:TextStyle(fontSize: 15,color: kTitleColor,fontWeight: FontWeight.w500,)),
                                Text("${balanceController.balanceDetails.payableDeliveryCharge!.toStringAsFixed(2)}",style:TextStyle(fontSize: 15,color: kTitleColor,fontWeight: FontWeight.w500,)),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Sub Total",style:TextStyle(fontSize: 15,color: kTitleColor,fontWeight: FontWeight.w500,)),
                                Text("${balanceController.balanceDetails.subTotal!.toStringAsFixed(2)}",style:TextStyle(fontSize: 15,color: kTitleColor,fontWeight: FontWeight.w500,)),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("COD Charte",style:TextStyle(fontSize: 15,color: kTitleColor,fontWeight: FontWeight.w500,)),
                                Text("${balanceController.balanceDetails.codCharge!.toStringAsFixed(2)}",style:TextStyle(fontSize: 15,color: kTitleColor,fontWeight: FontWeight.w500,)),
                              ],
                            ),
                            SizedBox(height: 25,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Available Balance",style:TextStyle(fontSize: 17,color: kTitleColor,fontWeight: FontWeight.w700,)),
                                Text("${balanceController.balanceDetails.availableBalance!.toStringAsFixed(2)}",style:TextStyle(fontSize: 17,color: kTitleColor,fontWeight: FontWeight.bold,)),
                              ],
                            ),
                            SizedBox(height: 40,),
                            InkWell(
                              onTap: (){
                                ClearableParcels().launch(context);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 9,horizontal: 7),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.green,width: 2)
                                ),
                                child: Text("Cleanable Parcels (${balanceController.balanceDetails.clearableParcels})",textAlign: TextAlign.center,style:TextStyle(fontSize: 18,color: Colors.green,fontWeight: FontWeight.w600,)),
                              ),

                            ),
                            SizedBox(height: 20,),
                          ],
                        ),
                      ),
                      ButtonGlobal(
                          buttontext: 'Withdraw Funds'.tr,
                          buttonDecoration: kButtonDecoration.copyWith(boxShadow:  [BoxShadow(color: Colors.black.withOpacity(.2),blurRadius: 5,offset: Offset(0,2))]),
                          onPressed: () {
                            CreatePaymentRequest(balanceDetails: balanceController.balanceDetails,).launch(context);
                          }),

                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text("Balance",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color:kMainColor ))),
                          Container(
                            height: 100,
                             width: double.infinity,
                            child: Card(
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                       SizedBox(width: 20,),
                                       Text("90.0 ${Get.find<GlobalController>().currency}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                                       SizedBox(width: 5,),
                                       Icon(Icons.more_rounded)
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                      Row(
                                        children: [
                                          Icon(Icons.add),
                                          SizedBox(width: 10,),
                                          Text("Top-up"),

                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          Icon(Icons.account_balance),
                                          SizedBox(width: 10,),
                                          Text("Withdraw"),

                                        ],
                                      ),

                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text("Overdraft Limit",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color:kMainColor ))),
                          Container(
                            height: 70,
                            width: double.infinity,
                            child: Card(
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(width: 20,),
                                      Text("90.0 ${Get.find<GlobalController>().currency}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),

                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.insert_comment),
                                        SizedBox(width: 10,),
                                        Text("Request Limit Increase"),

                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
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
                                itemCount: 4,
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
                                              children: const <TextSpan>[
                                                TextSpan(text: '#7868768787', style: TextStyle(fontWeight: FontWeight.w600,)),
                                                TextSpan(text: '  Delivery Charge', style: TextStyle(fontWeight: FontWeight.w600)),
                                              ],
                                            ),
                                          ),

                                          Text("Success",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.red),)
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
                                              children: const <TextSpan>[
                                                TextSpan(text: '07-05-2024', style: TextStyle(fontWeight: FontWeight.normal,)),
                                                TextSpan(text: ' | 07:06 PM', style: TextStyle(fontWeight: FontWeight.normal)),
                                              ],
                                            ),
                                          ),

                                          Text("-90.0 ${Get.find<GlobalController>().currency}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),
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
                                              text: 'Task ',
                                              style: TextStyle(color: Colors.black,fontSize: 14),
                                              children: const <TextSpan>[
                                                TextSpan(text: '5657657786 ', style: TextStyle(fontWeight: FontWeight.normal,)),
                                                TextSpan(text: 'Charges', style: TextStyle(fontWeight: FontWeight.normal)),
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
