import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:we_courier_merchant_app/Screen/Parcel/parcel_history_details.dart';

import '../../Controllers/parcel_controller.dart';
import '../../Models/invoice_detials_model.dart';
import '../Widgets/constant.dart';
import '../Widgets/shimmer/parcel_shimmer.dart';
class ParcelPageHistory extends StatefulWidget {

  ParcelPageHistory({Key? key,}) : super(key: key);

  @override
  State<ParcelPageHistory> createState() => _ParcelPageHistoryState();
}

class _ParcelPageHistoryState extends State<ParcelPageHistory> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: kMainColor,
      appBar: AppBar(
        title: Text(
          'Order History'.tr,
          style: kTextStyle.copyWith(color: kBgColor),
        ),

        backgroundColor: kMainColor,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: kBgColor),
      ),
      body: GetBuilder<ParcelController>(
          init: ParcelController(),
          builder: (parcel) => Container(
              padding: const EdgeInsets.all(10.0),

              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0.0),
                  topRight: Radius.circular(0.0),
                ),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Container(
                    //   height: 70,
                    //   width: double.infinity,
                    //
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: [
                    //
                    //
                    //       Column(children: [
                    //
                    //         Row(
                    //           children: [
                    //             Text("0",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19)),
                    //             SizedBox(width: 5,),
                    //             Icon(Icons.check,color: Colors.green,)
                    //           ],
                    //         ),
                    //         SizedBox(height: 4,),
                    //         Text("Successful"),
                    //
                    //       ],),
                    //           Text("|"),
                    //       Column(children: [
                    //
                    //         Row(
                    //           children: [
                    //             Text("0",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19)),
                    //             SizedBox(width: 5,),
                    //             Icon(Icons.clear_rounded,color: Colors.red,)
                    //           ],
                    //         ),
                    //         SizedBox(height: 4,),
                    //         Text("Cancel"),
                    //
                    //       ],),
                    //
                    //     ],
                    //   ),
                    //
                    // ),
                    parcel.parcelHistory.isEmpty? Padding(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: Center(child: Text("No History Data")),
                    ) :
                   ListView.builder(
                     itemCount: parcel.parcelHistory.length,
                     shrinkWrap: true,
                     primary: false,
                     itemBuilder: (BuildContext context, int index) {
                     return InkWell(
                       onTap: () {
                         Get.to(()=>ParcelHistoryDetails(parcel: parcel.parcelHistory[index]));
                       },
                       child: Container(
                       
                         width: double.infinity,
                         child: Card(
                           color: Colors.white,
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Padding(
                                 padding: const EdgeInsets.only(
                                   right: 10.0,
                                   left: 10.0,
                                   top: 12.0,
                       
                                 ),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Text("#${parcel.parcelHistory[index].trackingId}",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17),),
                                     Container(
                                       height: 40,
                                       width: 100,
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(50),
                                         color: kMainColor,
                                       ),
                                       child: Center(child: Text("${parcel.parcelHistory[index].statusName}",style: TextStyle(color: Colors.white))),
                                     )
                                   ],
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(
                                   right: 10.0,
                                   left: 10.0,
                                   top: 8.0,
                       
                                 ),
                                 child: Text("${parcel.parcelHistory[index].merchantUserName}",style: TextStyle(fontWeight: FontWeight.bold,),),
                               ),
                               Divider(
                                 indent: 10,
                                 endIndent: 10,
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(
                                   right: 10.0,
                                   left: 10.0,
                       
                       
                                 ),
                                 child: Text("${parcel.parcelHistory[index].merchantAddress}",),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(
                                   right: 10.0,
                                   left: 10.0,
                                   top: 2,
                       
                                 ),
                                 child: Text("${parcel.parcelHistory[index].pickupDate}",style: TextStyle(fontSize: 12)),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(
                                   right: 10.0,
                                   left: 10.0,
                                   top: 8.0,
                       
                                 ),
                                 child: Text("${parcel.parcelHistory[index].customerName}",style: TextStyle(fontWeight: FontWeight.bold,),),
                               ),
                               Divider(
                                 indent: 10,
                                 endIndent: 10,
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(
                                   right: 10.0,
                                   left: 10.0,
                       
                       
                                 ),
                                 child: Text("${parcel.parcelHistory[index].customerAddress}",),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(
                                     right: 10.0,
                                     left: 10.0,
                                     top: 2,
                                     bottom: 10
                                 ),
                                 child: Text("${parcel.parcelHistory[index].deliveryDate}",style: TextStyle(fontSize: 12)),
                               ),
                             ],
                           ),
                         ),
                       ),
                     );
                   },

                   ),

                  ],
                ),
              )
          )
      ),
    );
  }
}