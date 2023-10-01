import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voco_task/view/participants_page.dart';

import '../core/auth_manager.dart';
import '../model/user_model.dart';
import 'login_page.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    controlToLogin();
  }

  Future<void> controlToLogin() async {
    await ref.read(AuthProvider).fetchUserLogin();
    if (ref.read(AuthProvider).isLogin) {
      await Future.delayed(const Duration(seconds: 1));
      ref.read(AuthProvider).userModel = UserModel();

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const ParticipantsPage()));
    } else {
      await Future.delayed(const Duration(seconds: 3));
      Navigator.pushReplacement(
          context, (MaterialPageRoute(builder: (context) => LoginPage())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Center(
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                maxRadius: 120,
                minRadius: 100,
                // child: AssetManager.getPngImageSizedNFilled("logo", fit: BoxFit.fitHeight, height: 200),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                "Hoş Geldiniz!",
              ),
            ),
          ),
          const Expanded(
              flex: 4,
              child: Center(
                child: CircularProgressIndicator(),
              ))
        ],
      ),
    );
  }
}
