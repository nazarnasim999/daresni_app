import 'package:darasni/Controllers/controllers_init.dart';
import 'package:darasni/Models/LocationModel/area_list.dart';
import 'package:darasni/Models/LocationModel/city_list.dart';
import 'package:darasni/Models/LocationModel/country_list.dart';
import 'package:darasni/Models/LocationModel/multi_cites.dart';
import 'package:darasni/Models/LocationModel/multi_states.dart' hide MultiStateList;
import 'package:darasni/Models/LocationModel/state_list.dart';
import 'package:darasni/Services/HttpServices/api_services.dart';
import 'package:darasni/Services/HttpServices/api_urls.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  CountryListModel? countryListModel;
  StateList? stateList;
  CityList? cityList;
  AreaList? areaList;

  Future<void> getCountryList() async {
    countryListModel = null;

    final response = await ApiService.getMethod(url: ApiUrls.GET_COUNTRY);

    if (response == null || response.statusCode != 200 || response.body.isEmpty) {
      return;
    }
    countryListModel = countryListFromJson(response.body);

    update();
  }

  List<int> multiCountriesId = <int>[];
  List<States> multiStatesList = <States>[];
  List<int> multiStatesID = <int>[];
  MultiStatesModel? multiStatesModel;

  Future<void> getMultiStateList() async {
    multiStatesList = [];
    update();
    Map<String, String> body = {"country_list": "$multiCountriesId"};

    final response = await ApiService.postMethod(url: ApiUrls.GET_MULTI_STATE, body: body);

    if (response == null || response.statusCode != 200 || response.body.isEmpty) {
      return;
    }
    multiStatesModel = multiStatesFromJson(response.body);
    multiStatesModel?.data?.forEach((element) {
      element.states?.forEach((element) {
        multiStatesList.add(element);
      });

      // multiStatesList = element.states!;
    });

    update();
  }

  MultiCitesModel? multiCitesModel;
  List<Areas> multiCitesList = <Areas>[];

  List<int> multiCitesID = <int>[];

  Future<void> getMultiCitesList() async {
    Map<String, String> body = {"state_list": "$multiStatesID"};

    final response =
        await ApiService.postMethod(url: ApiUrls.GET_MULTI_CITIES_FORM_STATE, body: body);

    if (response == null || response.statusCode != 200 || response.body.isEmpty) {
      return;
    }

    multiCitesModel = multiCitesFromJson(response.body);

    multiCitesModel?.data?.forEach((element) {
      multiCitesList = element.cities!;
    });

    update();
  }

  Future<void> getStateList({int? countryId}) async {
    stateList = null;
    areaList = null;
    final response = await ApiService.getMethod(
        url: "${ApiUrls.GET_STATE}${countryId == null ? authController.countryID : countryId}");

    if (response == null || response.statusCode != 200 || response.body.isEmpty) {
      return;
    }
    stateList = stateListFromJson(response.body);
    update();
  }

  Future<void> getCityList() async {
    final response =
        await ApiService.getMethod(url: "${ApiUrls.GET_CITY}${authController.stateID}");

    if (response == null || response.statusCode != 200 || response.body.isEmpty) {
      return;
    }
    cityList = cityListFromJson(response.body);
  }

  Future<void> getAreaList({required int? countryID, required int? stateId}) async {
    areaList = null;

    update();
    final response = await ApiService.getMethod(
        url: countryID == null
            ? "${ApiUrls.GET_AREA}country_id=${authController.countryID}&state_id=${authController.stateID}"
            : "${ApiUrls.GET_AREA}country_id=$countryID");

    if (response == null || response.statusCode != 200 || response.body.isEmpty) {
      return;
    }
    areaList = areaListFromJson(response.body);
    update();
  }
}
