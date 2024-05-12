import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:we_courier_merchant_app/Controllers/dashboard_controller.dart';

import '../Widgets/constant.dart';
import '../Widgets/shimmer/dashboard_shimmer.dart';
class Terms_Condition extends StatefulWidget {
  const Terms_Condition({super.key});

  @override
  State<Terms_Condition> createState() => _Terms_ConditionState();
}

class _Terms_ConditionState extends State<Terms_Condition> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Terms & Condition",style: TextStyle(color: Colors.white)),

          backgroundColor: kMainColor),
      body: GetBuilder<DashboardController>(
        init: DashboardController(),
        builder: (_dashboardController) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0,left: 8.0,top: 10),
             child: Column(
               children: [
                 const SizedBox(height: 10.0),
                 _dashboardController.dashboardLoader
                     ? DashboardShimmer() : Column(

                  children: [

                    Text(_dashboardController.terms_condition!.updatedAt.toString()),
                    SizedBox(height: 10,),
                    Text(_dashboardController.terms_condition!.title.toString(),

                        style: TextStyle(
                                decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,fontSize: 20)),
                    SizedBox(height: 10,),
                    Text(_dashboardController.terms_condition!.description.toString(),style: TextStyle( fontSize: 13)),

                  ],
                             ),

               ],
             ),
          ),
        ),),
    );
  }
}
