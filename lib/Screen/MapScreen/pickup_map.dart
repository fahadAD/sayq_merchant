import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';

import '../../Controllers/parcel_controller.dart';
import '../../main.dart';
import '../Widgets/constant.dart';

class PickupMapsScreen extends StatefulWidget {
  const PickupMapsScreen({super.key});

  @override
  State<PickupMapsScreen> createState() => _PickupMapsScreenState();
}

class _PickupMapsScreenState extends State<PickupMapsScreen> {
  ParcelController parcelController = Get.put(ParcelController());

  final Completer<GoogleMapController> completer = Completer();
  PickResult? result;
  LatLng? currentLatLng;
  void getCurrentPossition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await requestLocationPermission();
    } else {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        currentLatLng = LatLng(position.latitude, position.longitude);
      });
    }
    setState(() {
      currentLatLng = currentLatLng;
    });
  }

  @override
  void initState() {
    getCurrentPossition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select pick up location'),
      ),
      body: currentLatLng == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                PlacePicker(
                  region: 'bd',
                  // apiKey: 'AIzaSyCDve4ghJMb9X_S7RpwzAtpxFNq94c-qrQU',
                  // apiKey: 'AIzaSyDNTU2E3fJ55nYm5Eawb4rnlkHP21U8MdU',
                  apiKey: 'AIzaSyBxwyLXWNfom9BRx0Ccr_PdIzDCHyKDeNo',
                  initialPosition: LatLng(currentLatLng!.latitude, currentLatLng!.longitude),
                  automaticallyImplyAppBarLeading: false,
                  searchForInitialValue: true,
                  autocompleteLanguage: 'bn_BD',
                  autocompleteRadius: 1000,
                  hintText: 'SEARCH_LOCATION',
                  usePlaceDetailSearch: true,
                  onCameraMove: (position) {
                    parcelController.pickup_lat.value = position.target.latitude.toString();
                    parcelController.pickup_long.value = position.target.longitude.toString();
                    // orderController.pickupLat.value = position.target.latitude;
                    // orderController.pickupLong.value = position.target.longitude;
                    // print(orderController.pickupLat.value);
                    // print(orderController.pickupLong.value);
                    // print('============ latitude not data=============${orderController.pickupLong.value = position.target.latitude}===========');
                    // print('============ longitude not data=============${orderController.pickupLong.value = position.target.longitude}===========');
                    print('============ longitude not data=============${parcelController.pickup_lat.value = position.target.latitude.toString()}===========');
                    print('============ longitude not data=============${parcelController.pickup_long.value = position.target.longitude.toString()}===========');
                  },
                  selectInitialPosition: true,
                  pickArea: CircleArea(radius: 2, center: LatLng(currentLatLng!.latitude, currentLatLng!.longitude)),
                  selectedPlaceWidgetBuilder: (context, result, state, isFocused) {
                    if (state == SearchingState.Searching) {
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: Card(
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              color: Colors.white,
                              child: const Center(
                                child: SizedBox(width: 25, height: 25, child: CircularProgressIndicator()),
                              )),
                        ),
                      );
                    } else {
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: Card(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(8),
                            color: Colors.white,
                            child: Column(
                              children: [
                                Text(
                                  '${result!.formattedAddress}',
                                  textAlign: TextAlign.center,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: kMainColor, minimumSize: const Size(double.infinity, 40)),
                                  onPressed: () {
                                    setState(() {
                                      parcelController.pickupAddress = result.formattedAddress!.toString();
                                    });
                                    // orderController.pickupLocation.value = result.formattedAddress!.toString();
                                    Get.back();
                                  },
                                  child: const Text('Add Address', style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
                // Positioned(
                //   left: MediaQuery.sizeOf(context).width * .15,
                //   bottom: MediaQuery.of(context).size.aspectRatio,
                //   child: Column(
                //     children: [
                //       const Text(
                //         'Place the marker on desire location \n and then Press ok',
                //         textAlign: TextAlign.center,
                //         style: TextStyle(
                //             fontSize: 16, fontWeight: FontWeight.bold),
                //       ),
                //       ElevatedButton(
                //           style: ElevatedButton.styleFrom(
                //               minimumSize: Size(
                //                   MediaQuery.sizeOf(context).width * 0.5,
                //                   twentyPixelheight(context) * 2.5),
                //               backgroundColor: ColorPallate.primaryColor,
                //               foregroundColor: Colors.black),
                //           onPressed: () {
                //             // orderController.distanceKm.value =
                //             //     orderController.calculateDistance(
                //             //   orderController.pickupLat.value,
                //             //   orderController.pickupLong.value,
                //             //   orderController.dropLat.value,
                //             //   orderController.dropLong.value,
                //             // );
                //             // print(orderController.distanceKm.value
                //             //     .toStringAsFixed(2));

                //             Get.back();
                //           },
                //           child: const Text('OK'))
                //     ],
                //   ),
                // ),
              ],
            ),
    );
  }
}
