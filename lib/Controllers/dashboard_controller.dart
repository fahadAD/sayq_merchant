import 'dart:convert';
import '../Models/balance_detials_model.dart';
import '../Models/dashboard_model.dart';
import '../Models/news_offers_model.dart';
import '../Models/tody_parcel_model.dart';
import '../Models/tterm_condition_model.dart';
import '/services/api-list.dart';
import '/services/server.dart';
import '/services/user-service.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  UserService userService = UserService();
  Server server = Server();

  String? userID;

  bool dashboardLoader = true;
  bool commonLoader = false;
  bool loader = false;
  // late DataDashboard dashboardData;
  var dashboardData = DataDashboard();
    TermsAndCondition? terms_condition;
  List<NewsOffers> offersList = <NewsOffers>[];
  List<TodaysParcels> today_parcelList = <TodaysParcels>[];

  @override
  void onInit() {
    getDashboard();
    getOfferList();
    getTermsCondition();
    getBalanceDetails();
    getTodayParcel();
    super.onInit();
  }

  getDashboard() {
    server.getRequest(endPoint: APIList.dashboard).then((response) {
      if (response != null && response.statusCode == 200) {
        dashboardLoader = false;
        final jsonResponse = json.decode(response.body);
        var dashboard = DashboardModel.fromJson(jsonResponse);
        dashboardData = dashboard.data!;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {
        dashboardLoader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      }
    });
  }

  getTermsCondition() {
    server.getRequest(endPoint: APIList.terms_and_condition).then((response) {
      if (response != null && response.statusCode == 200) {
        dashboardLoader = false;
        print("fagad${response.body}");
        final jsonResponse = json.decode(response.body);
        var terms_and_condition = TermsConditionModel.fromJson(jsonResponse);
        terms_condition = terms_and_condition.data!.termsAndCondition!;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {
        dashboardLoader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      }
    });
  }

  getOfferList() {
    offersList = <NewsOffers>[];
    server.getRequest(endPoint: APIList.offerList).then((response) {
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        var offers = NewsOffersModel.fromJson(jsonResponse);
        offersList = offers.data!.newsOffers!;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {
        dashboardLoader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      }
    });
  }
  BalanceDetailsModel balanceDetails = BalanceDetailsModel();
  getBalanceDetails() {
    server.getRequest(endPoint: APIList.balanceDetails).then((response) {
      if (response != null && response.statusCode == 200) {
        loader = false;
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);
        balanceDetails = BalanceDetailsModel.fromJson(jsonResponse);
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {
        loader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      }
    });
  }


  getTodayParcel() {
    server.getRequest(endPoint: APIList.today_parcel).then((response) {
      print(json.decode(response.body));
      print("today parcel body =${response.body}");
      print("today parcel statusCode=${response.statusCode}");
      if (response != null && response.statusCode == 200) {
        print("today parcel body =${response.body}");
        print("today parcel statusCode=${response.statusCode}");
        loader = false;
        final jsonResponse = json.decode(response.body);
        var parcelData = TodayParcelModel.fromJson(jsonResponse);
        today_parcelList = <TodaysParcels>[];
        today_parcelList.addAll(parcelData.data!.parcels!);
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {
        loader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      }
    });
  }


}
