import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:voco_task/core/cache_manager.dart';
import 'package:voco_task/model/login_request_model.dart';
import 'package:voco_task/model/login_response_model.dart';
import 'package:voco_task/view/login_page.dart';
import 'package:voco_task/view/participants_page.dart';

import '../service/login_service.dart';

abstract class LoginController extends ConsumerState<LoginPage>
    with CacheManager {
  late final LoginService loginService;
  final globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    loginService = LoginService();
  }

  Future<void> fetchLogin(LoginRequestModel requestModel) async {
    final response = await loginService.fetchLogin(requestModel);

    if (response != null) {
      saveToken(response.token ?? "");
      navigateToHome();
    }
  }

  void navigateToHome() {
    Navigator.of(context).popUntil((route) => false);
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const ParticipantsPage()));
  }

  // Future<LoginResponseModel> fetchLogin(LoginRequestModel requestModel) async {
  //   String url = "https://reqres.in/api/login";

  //   Response response = await post(Uri.parse(url), body: requestModel.toJson());
  //   if (response.statusCode == 200) {
  //     print('Login successfully');
  //     return LoginResponseModel.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception("Failed to load data");
  //   }
  // }
}
