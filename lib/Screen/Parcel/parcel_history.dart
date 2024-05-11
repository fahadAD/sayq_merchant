import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

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
              margin: EdgeInsets.only(top: 20),
              height: MediaQuery.of(context).size.height,
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
                  children: [
                    Container(
                      height: 70,
                      width: double.infinity,

                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [


                          Column(children: [

                            Row(
                              children: [
                                Text("0",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19)),
                                SizedBox(width: 5,),
                                Icon(Icons.supervised_user_circle,color: Colors.green,)
                              ],
                            ),
                            SizedBox(height: 4,),
                            Text("Successful"),

                          ],),
                              Text("|"),
                          Column(children: [

                            Row(
                              children: [
                                Text("0",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19)),
                                SizedBox(width: 5,),
                                Icon(Icons.content_cut,color: Colors.red,)
                              ],
                            ),
                            SizedBox(height: 4,),
                            Text("Cancel"),

                          ],),
                        ],
                      ),

                    ),


                  ],
                ),
              )
          )
      ),
    );
  }
}