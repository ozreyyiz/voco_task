import 'dart:convert';

import 'package:http/http.dart';
import 'package:voco_task/model/login_request_model.dart';
import 'package:voco_task/model/login_response_model.dart';

abstract class ILoginService {
  final String path = 'https://reqres.in/api/login';

  Future<LoginResponseModel?> fetchLogin(LoginRequestModel requestModel);
}

class LoginService extends ILoginService {
  @override
  Future<LoginResponseModel?> fetchLogin(LoginRequestModel requestModel) async {
    try {
      final response = await post(Uri.parse(path), body: requestModel.toJson());
      if (response.statusCode == 200) {
        return LoginResponseModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
