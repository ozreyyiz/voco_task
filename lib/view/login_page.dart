import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:voco_task/model/login_request_model.dart';
import '../controller/login_controller.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends LoginController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late LoginRequestModel requestModel;

  @override
  void initState() {
    super.initState();
    requestModel = LoginRequestModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const DelayedDisplay(
                delay: Duration(milliseconds: 1000),
                child: Text(
                  "Welcome to",
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 35,
                  ),
                ),
              ),
              const DelayedDisplay(
                delay: Duration(milliseconds: 1500),
                child: Text(
                  "POCO",
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(hintText: 'Email'),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(hintText: 'Password'),
              ),
              const SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  requestModel.email = emailController.text;
                  requestModel.password = passwordController.text;

                  if (requestModel.email!.isNotEmpty &&
                      requestModel.password!.isNotEmpty &&
                      requestModel.email!.contains("@")) {
                    fetchLogin(requestModel);
                  } else {
                    Fluttertoast.showToast(
                      msg: "Try Again",
                      backgroundColor: Colors.red,
                      textColor: Colors.red,
                      // Fluttertoast parameters is not working. I didn't understand.
                    );
                  }
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Text('Login'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
