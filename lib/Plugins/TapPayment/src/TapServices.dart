// ignore_for_file: file_names

import 'dart:convert';

import 'package:darasni/Utils/utils.dart';
import 'package:http/http.dart' as http;

class TapServices {
  final String apiKey;
  final Map paymentData;
  String basePath = "https://api.tap.company/";
  String version = "v2";

  TapServices({required this.apiKey, required this.paymentData});

  sendPayment() async {
    String domain = "$basePath$version/charges";
    try {
      logger.i(paymentData.runtimeType);
      var response = await http.post(Uri.parse(domain), body: json.encode(paymentData), headers: {
        "Authorization": "Bearer $apiKey",
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
      });
      var body = json.decode(response.body);
      if (response.statusCode == 200) {
        logger.wtf(body);
        return {'error': false, 'message': body};
      } else {
        logger.i(body);
        return {'error': true, 'message': "${body["errors"]?[0]?["description"]}"};
      }
    } catch (e) {
      logger.e("$e");
      return {'error': true, 'message': "Unable to proceed, check your internet connection."};
    }
  }

  confirmPayment(tapId) async {
    String domain = "$basePath$version/charges/$tapId";
    try {
      var response = await http.get(Uri.parse(domain),
          headers: {"content-type": "application/json", 'Authorization': 'Bearer $apiKey'});

      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return {'error': false, 'message': "Confirmed", 'data': body};
      } else {
        return {'error': true, 'message': "Payment inconclusive.", 'data': body};
      }
    } catch (e) {
      return {'error': true, 'message': e, 'exception': true, 'data': null};
    }
  }
}
