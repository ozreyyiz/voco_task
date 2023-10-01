import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:voco_task/model/login_request_model.dart';
import 'package:voco_task/model/login_response_model.dart';

class LoginController {
  Future<LoginResponseModel> loginUser(LoginRequestModel requestModel) async {
    String url = "https://reqres.in/api/login";

    Response response = await post(Uri.parse(url), body: requestModel.toJson());
    if (response.statusCode == 200) {
      print('Login successfully');
      return LoginResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load data");
    }
  }
}
