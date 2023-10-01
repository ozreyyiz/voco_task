import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voco_task/core/cache_manager.dart';
import 'package:voco_task/model/user_model.dart';

class AuthenticationManager with CacheManager {
  AuthenticationManager() {
    fetchUserLogin();
  }

  bool isLogin = false;
  UserModel? userModel;

  Future<void> fetchUserLogin() async {
    final token = await getToken();
    if (token != null) {
      isLogin = true;
    }
  }
}

final AuthProvider = Provider((ref) => AuthenticationManager());
