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
                                Icon(Icons.check,color: Colors.green,)
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
                                Icon(Icons.clear_rounded,color: Colors.red,)
                              ],
                            ),
                            SizedBox(height: 4,),
                            Text("Cancel"),

                          ],),

                        ],
                      ),

                    ),
                   ListView.builder(
                     itemCount: 3,
                     shrinkWrap: true,
                     primary: false,
                     itemBuilder: (BuildContext context, int index) {
                     return Container(

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
                                   Text("#78677777777",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17),),
                                   Container(
                                     height: 40,
                                     width: 100,
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(50),
                                       color: kMainColor,
                                     ),
                                     child: Center(child: Text("Successful",style: TextStyle(color: Colors.white))),
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
                               child: Text("Ninja trading bahrain",style: TextStyle(fontWeight: FontWeight.bold,),),
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
                               child: Text("Ninja trading bahrain, Building,Main road",),
                             ),
                             Padding(
                               padding: const EdgeInsets.only(
                                 right: 10.0,
                                 left: 10.0,
                                 top: 2,

                               ),
                               child: Text("07-02-2024  04:56 PM",style: TextStyle(fontSize: 12)),
                             ),
                             Padding(
                               padding: const EdgeInsets.only(
                                 right: 10.0,
                                 left: 10.0,
                                 top: 8.0,

                               ),
                               child: Text("Ninja trading bahrain Customer",style: TextStyle(fontWeight: FontWeight.bold,),),
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
                               child: Text("Ninja trading bahrain, Building,Main road",),
                             ),
                             Padding(
                               padding: const EdgeInsets.only(
                                   right: 10.0,
                                   left: 10.0,
                                   top: 2,
                                   bottom: 10
                               ),
                               child: Text("07-02-2024  04:56 PM",style: TextStyle(fontSize: 12)),
                             ),
                           ],
                         ),
                       ),
                     );
                   },

                   )

                  ],
                ),
              )
          )
      ),
    );
  }
}