import 'dart:convert';

import 'package:hexa_delivery/model/dto.dart';
import 'package:http/http.dart' as http;

class LoginResource {
  Future<UserOnlyUID?> requestCode(String emailAddress) async {
    // Map<String, String> headers = {
    //   'Content-Type': 'multipart/form-data',
    // };

    var request = http.MultipartRequest(
        'POST', Uri.parse('http://delivery.hexa.pro/login/send_auth_number'));

    var body = {
      'email_address': emailAddress,
    };

    request.fields.addAll(body);
    // request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var res = await response.stream.bytesToString();

    print(res);
    if (response.statusCode == 201) {
      // If the call to the server was successful, parse the JSON
      Map<String, dynamic> data = json.decode(res)["data"]!;
      print(data);
      int uID = data["uid"];
      return UserOnlyUID(uID);
      // implement return response object
    } else {
      // If that call was not successful, throw an error.
      return null;
    }
  }

  Future<UserValified> checkCode(UserOnlyUID userOnlyUID, int code) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://delivery.hexa.pro/login/verify_auth_number'));

    var body = {
      'uid': userOnlyUID.getUID().toString(),
      'auth_number': code.toString(),
    };

    request.fields.addAll(body);

    http.StreamedResponse response = await request.send();

    var res = await response.stream.bytesToString();

    print(res);
    if (response.statusCode == 201) {
      Map<String, dynamic> data = json.decode(res)["data"]!;
      print(data);
      int uID = data["uid"];
      String token = data["Access-Token"];
      return UserValified(
          user: User(uID, token),
          isValified: true,
          isCodeExpired: false,
          isCodeWrong: false);
    } else if (response.statusCode == 417) {
      return UserValified(
          isValified: false, isCodeExpired: false, isCodeWrong: true);
    } else if (response.statusCode == 410) {
      return UserValified(
          isValified: false, isCodeExpired: true, isCodeWrong: false);
    } else {
      return UserValified(
          isValified: false, isCodeExpired: false, isCodeWrong: false);
    }
  }
}
