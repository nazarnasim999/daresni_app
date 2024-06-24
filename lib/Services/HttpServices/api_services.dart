import 'dart:convert';

import 'package:darasni/Controllers/controllers_init.dart';
import 'package:darasni/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {

  static logout(String resBody)async {
    if(resBody.contains("unauthenticated")){
      await authController.logOut();
    }
  }

  static Future<http.Response?> getMethod({required String url}) async {
    return await http.get(
      Uri.parse(url),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-type": "application/json",
        // TODO: ADD TOKEN
        "Authorization": "Bearer ${authController.getUser()?.token}",
      },
    ).then((res) {
      logger.wtf(
          'URL => $url\nResponse StatusCode => ${res.statusCode}\nResponse Body => ${res.body}');
      if (res.statusCode == 200 || res.statusCode == 201) {
        return res;
      }
      logout(res.body);
      return null;
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('stackTrace => $stackTrace');
      // AppConst.errorOccurAlert();
      return null;
    });
  }

  static Future<http.Response?> postMethod(
      {required String url, Map? body, bool bypassStatusCode = false}) async {
      print(body);
    return await http.post(
      Uri.parse(url),
      body: body != null ? json.encode(body) : null,
      headers: <String, String>{
        "Accept": "application/json",
        "Content-type": "application/json",
        //TODO: ADD TOKEN
        "Authorization": "Bearer ${authController.getUser()?.token}",
      },
    ).then((res) {
      logger
          .i('URL => $url\nResponse StatusCode => ${res.statusCode}\nResponse Body => ${res.body}');

      if (res.statusCode != 200 && res.statusCode != 201 && !bypassStatusCode) {
        return null;
      }
      logout(res.body);

      return res;
    }).onError((error, stackTrace) {
      debugPrint('Error in api call => $error\nUrl => $url');
      logger.e('stackTrace => $stackTrace');
      return null;
    });
  }

  static Future<String?> postMultiPartQuery(String url,
      {Map<String, String>? fields, Map<String, String>? files}) async {
    try {
      var headers = {
        "Accept": "application/json",
        "Content-type": "application/json",
        // TODO:ADD TOKEN
        "Authorization": "Bearer ${authController.getUser()?.token}",
      };

      var request = http.MultipartRequest('POST', Uri.parse(url));
      if (fields != null) {
        request.fields.addAll(fields);
      }

      if (files != null) {
        files.forEach((key, value) async {
          request.files.add(await http.MultipartFile.fromPath(key, value));
        });
      }
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      String resBody = await response.stream.bytesToString();

      logger.d(response.statusCode);
      if (response.statusCode == 200) {
        logger.i(resBody);
        return resBody;
      } else {
        if(resBody.contains("unauthenticated")){
          logout(resBody);
        }
        logger.e(resBody);
        return null;
      }
    } catch (error) {
      logger.e('Error: ApiService -> postMultiPartQuery -> url = $url => $error');
      return null;
    }
  }

}
