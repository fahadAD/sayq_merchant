
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shimmer/shimmer.dart';

import '../../Controllers/global-controller.dart';
import '../../Controllers/profile_controller.dart';
import '../../utils/image.dart';
import '../../utils/style.dart';
import '../Payment/balance_details.dart';
import '../Support/support.dart';
import '../Widgets/button_global.dart';
import '../Widgets/constant.dart';
import 'package:get/get.dart';

import '../Widgets/profile_card.dart';
import '../Widgets/shimmer/profile_shimmer.dart';
import 'change_language_view.dart';
import 'change_password_view.dart';
import 'edit_profile_view.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ProfileController profileController = ProfileController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (profile) =>
            Scaffold(
          backgroundColor: kMainColor,
          appBar: AppBar(
            title: Text(
              'profile'.tr,
              style: kTextStyle.copyWith(color: kBgColor),
            ),
            backgroundColor: kMainColor,
            elevation: 0.0,
            iconTheme: const IconThemeData(color: kBgColor),
          ),
          body: Container(
            clipBehavior: Clip.antiAlias,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(color: kGreyTextColor.withOpacity(0.2)),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              color: Colors.white,
            ),
            child:
            SingleChildScrollView(
              child: Container(child:
              Column(
                children: [
                  const SizedBox(height: 20.0),
                  Column(
                    children: [
                      profile.profileLoader
                          ? ProfileShimmer()
                          :
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                        child:
                        SingleChildScrollView(
                          child: SizedBox(
                            child: Column(
                              children: [
                                // SizedBox(
                                //   child: Column(children: [
                                //     const SizedBox(
                                //       height: 10,
                                //     ),
                                //     Stack(
                                //      clipBehavior: Clip.none,
                                //       children: [
                                //         SizedBox(
                                //           width: 100.w,
                                //           height: 100.h,
                                //           child: Center(
                                //             child:
                                //             CachedNetworkImage(
                                //               imageUrl:profile.profileUser.image.toString(),
                                //               imageBuilder: (context, imageProvider) =>
                                //                   CircleAvatar(
                                //                     radius: 50.0,
                                //                     backgroundColor: Colors.transparent,
                                //                     backgroundImage:imageProvider,
                                //                   ),
                                //
                                //               placeholder: (context, url) => Shimmer.fromColors(
                                //                 child: CircleAvatar(radius: 50.0),
                                //                 baseColor: Colors.grey[300]!,
                                //                 highlightColor: Colors.grey[400]!,
                                //               ),
                                //               errorWidget: (context, url, error) =>
                                //                   Icon(CupertinoIcons.person,size: 50,),
                                //             ),
                                //           ),
                                //         ),
                                //         Positioned(
                                //           top: 75,
                                //           right: 20,
                                //           child: InkWell(
                                //             onTap: (() => Get.to( EditProfileView())),
                                //             child: SizedBox(
                                //               width: 30.w,
                                //               height: 30.h,
                                //               child: CircleAvatar(
                                //                 backgroundColor: Colors.white,
                                //                 child: SizedBox(
                                //                   width: 30.w,
                                //                   height: 30.h,
                                //                   child: CircleAvatar(
                                //                     backgroundColor: darkGray,
                                //                     child: Image.asset(
                                //                       Images.iconEdit,
                                //                       fit: BoxFit.cover,
                                //                       height: 22.h,
                                //                       width: 22.w,
                                //                     ),
                                //                   ),
                                //                 ),
                                //               ),
                                //             ),
                                //           ),
                                //         ),
                                //       ],
                                //     ),
                                //     const SizedBox(
                                //       height: 16,
                                //     ),
                                //      Text(
                                //       profile.profileUser.name.toString(),
                                //       style: TextStyle(
                                //         fontFamily: 'Rubik',
                                //         fontSize: 16,
                                //         color: fontColor,
                                //         fontWeight: FontWeight.w700,
                                //       ),
                                //     ),
                                //     SizedBox(
                                //       height: 5.h,
                                //     ),
                                //      Text(
                                //       profile.profileUser.email.toString(),
                                //       style: TextStyle(
                                //         fontFamily: 'Rubik',
                                //         fontSize: 14,
                                //         color: grayColor,
                                //         fontWeight: FontWeight.w500,
                                //       ),
                                //     ),
                                //     SizedBox(
                                //       height: 2.h,
                                //     ),
                                //      Text(
                                //       profile.profileUser.phone.toString(),
                                //       style: TextStyle(
                                //         fontFamily: 'Rubik',
                                //         fontSize: 14,
                                //         color: grayColor,
                                //         fontWeight: FontWeight.w500,
                                //       ),
                                //     ),
                                //   ]),
                                // ),
                                // SizedBox(height: 30,),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                //   children: [
                                //     SizedBox(width: 60,),
                                //     ProfileCard(
                                //       page: false,
                                //       topic: 'opening_balance'.tr,
                                //       amount: ' ${Get.find<GlobalController>()
                                //           .currency}${profile.profileMerchant.openingBalance.toString()}',
                                //       imgUrl: Images.logo,
                                //       cardColor: kSecondaryColor,
                                //     ),
                                //     const SizedBox(
                                //       width: 16,
                                //     ),
                                //     ProfileCard(
                                //       page: true,
                                //       topic: 'vat'.tr+'%',
                                //       amount: ' ${Get.find<GlobalController>()
                                //           .currency}${profile.profileMerchant.vat.toString()}',
                                //       imgUrl: Images.logo,
                                //       cardColor: kMainColor,
                                //     ),
                                //   ],
                                // ),
                                // SizedBox(height: 30,),
                                // ButtonGlobal(
                                //     buttontext: 'Check Balance ➤'.tr,
                                //     buttonDecoration: kButtonDecoration.copyWith(color: Colors.deepOrangeAccent.shade200,boxShadow:  [BoxShadow(color: Colors.black.withOpacity(.2),blurRadius: 3,offset: Offset(0,1))]),
                                //     onPressed: () {
                                //       setState(() {
                                //         const BalanceDetails().launch(context);
                                //       });
                                //     }),
                                // SizedBox(height: 30,),
                                // profileItem(EditProfileView(), Images.iconEditProfile,
                                //     "edit_profile".tr),
                                // profileItem(ChangePasswordView(), Images.iconChangePass,
                                //     "change_password".tr),
                                // profileItem(ChangeLanguageView(), Images.iconChangeLang,
                                //     "change_language".tr),
                                // SizedBox(height: 14,),
                                // InkWell(
                                //   onTap: () {
                                //     Get.find<GlobalController>().userLogout();
                                //   },
                                //   child: Column(
                                //     children: [
                                //       Row(
                                //         children: [
                                //           SvgPicture.asset(
                                //             Images.iconLogout,
                                //             height: 16.h,
                                //             width: 16.w,
                                //             fit: BoxFit.cover,
                                //           ),
                                //           SizedBox(
                                //             width: 16.h,
                                //           ),
                                //           Text(
                                //             "log_out".tr,
                                //             style: fontProfile,
                                //           ),
                                //         ],
                                //       ),
                                //       SizedBox(
                                //         height: 14.h,
                                //       ),
                                //     ],
                                //   ),
                                // ),

                                SizedBox(height: 10,),
                                  Row(children: [
   Stack(
     clipBehavior: Clip.none,
     children: [
       SizedBox(
         width: 80.w,
         height: 80.h,
         child: Center(
           child:
           CachedNetworkImage(
             imageUrl:profile.profileUser.image.toString(),
             imageBuilder: (context, imageProvider) =>
                 CircleAvatar(
                   radius: 50.0,
                   backgroundColor: Colors.transparent,
                   backgroundImage:imageProvider,
                 ),

             placeholder: (context, url) => Shimmer.fromColors(
               child: CircleAvatar(radius: 50.0),
               baseColor: Colors.grey[300]!,
               highlightColor: Colors.grey[400]!,
             ),
             errorWidget: (context, url, error) =>
                 Icon(CupertinoIcons.person,size: 50,),
           ),
         ),
       ),
       Positioned(
         top: 55,
         right: 40,
         child: InkWell(
           onTap: (() => Get.to( EditProfileView())),
           child: SizedBox(
             width: 30.w,
             height: 30.h,
             child: CircleAvatar(
               backgroundColor: Colors.white,
               child: SizedBox(
                 width: 30.w,
                 height: 30.h,
                 child: CircleAvatar(
                   backgroundColor: darkGray,
                   child: Image.asset(
                     Images.iconEdit,
                     fit: BoxFit.cover,
                     height: 22.h,
                     width: 22.w,
                   ),
                 ),
               ),
             ),
           ),
         ),
       ),
     ],
   ),
   SizedBox(width: 10,),
   Column(
     mainAxisAlignment: MainAxisAlignment.start,
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
     Text(
       profile.profileUser.name.toString(),
       style: TextStyle(
         fontFamily: 'Rubik',
         fontSize: 19,
         color: fontColor,
         fontWeight: FontWeight.bold,
       ),
     ),
     SizedBox(
       height: 4.h,
     ),
     Text(
       profile.profileUser.email.toString(),
       style: TextStyle(
         fontFamily: 'Rubik',
         fontSize: 14,
         color: grayColor,
         fontWeight: FontWeight.w500,
       ),
     ),
     SizedBox(
       height: 2.h,
     ),
     Text(
       profile.profileUser.phone.toString(),
       style: TextStyle(
         fontFamily: 'Rubik',
         fontSize: 14,
         color: grayColor,
         fontWeight: FontWeight.w500,
       ),
     ),
   ],)
 ],),
                                  SizedBox(height: 20,),
                                   Divider(
                                   thickness: 10,
                                     color: kMainColor,
                                  ),
                                SizedBox(height: 20,),
                               Card(
                                 color: Colors.white,
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   children: [
                                     ListTile(
                                       onTap: () {
                                         Get.to(()=>EditProfileView());
                                       },
                                       leading: Icon(Icons.add_business_sharp,color: Colors.black),
                                       title: Text("Branch Information",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                                       subtitle: Text("View and update your branch information",style: TextStyle(fontSize: 13)),


                                     ),
                                     Divider(),
                                     ListTile(
                                       onTap: () {
                                         // Get.to(()=>EditProfileView());
                                       },
                                       leading: Icon(Icons.map,color: Colors.black),
                                       title: Text("Business Addresses",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                                       subtitle: Text("View and update your addresses",style: TextStyle(fontSize: 13)),


                                     ),
                                     Divider(),
                                     ListTile(
                                       // onTap: () {
                                       //   // Get.to(()=>EditProfileView());
                                       // },
                                       leading: Icon(Icons.sd_card_alert,color: Colors.black),
                                       title: Text("Terms & Condition",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                                       subtitle: Text("Review Terms & Condition",style: TextStyle(fontSize: 13)),
                                     ),
                                     Divider(),
                                     ListTile(
                                       onTap: () {
                                         Get.to(()=>Support());
                                       },
                                       leading: Icon(Icons.contact_support_sharp,color: Colors.black),
                                       title: Text("Support",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                                       subtitle: Text("View and post a new support ticket",style: TextStyle(fontSize: 13)),


                                     ),

                                   ],
                                 ),
                               ),

                                SizedBox(height: 20,),
                                Card(
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        onTap: () {
                                          Get.to(()=>ChangeLanguageView());
                                        },
                                        leading: Icon(Icons.language,color: Colors.blue),
                                        title: Text("Change Language",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                                        subtitle: Text("Change app display language",style: TextStyle(fontSize: 13)),
                                      ),
                                      Divider(),
                                      ListTile(
                                        onTap: () {
                                          Get.to(()=>ChangePasswordView());
                                        },
                                        leading: Icon(Icons.password_sharp,color: Colors.black),
                                        title: Text("Change Password",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                                        subtitle: Text("View and change your password",style: TextStyle(fontSize: 13)),
                                      ),
                                      Divider(),
                                      ListTile(
                                        onTap: () {
                                          Get.find<GlobalController>().userLogout();
                                        },
                                        leading: Icon(Icons.logout,color: Colors.red),
                                        title: Text("Logout",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                                        subtitle: Text("Logout for this account",style: TextStyle(fontSize: 13)),
                                      ),


                                    ],
                                  ),
                                ),
                            SizedBox(height: 90,),

                              ],
                            ),
                          ),
                        )

                      ),
                    ],
                  ),
                ],
              ),
              ),
            ),
          )
        ),
    );
  }

  InkWell profileItem(route, icon, textValue) {
    return InkWell(
      onTap: () => Get.to(route),
      child:
      Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              SvgPicture.asset(
                icon,
                height: 18.h,
                width: 18.w,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 16.h,
              ),
              Text(
                "$textValue",
                style: fontProfile,
              ),
            ],
          ),
          SizedBox(
            height: 14.h,
          ),
          const Divider(
            thickness: 1,
            endIndent: 10,
            color: dividerColor,
          ),
        ],
      ),
    );
  }

}