import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:voco_task/model/login_request_model.dart';
import 'package:voco_task/view/participants_page.dart';

import '../controller/login_controller.dart';

class LoginPage extends ConsumerStatefulWidget {
  LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends LoginController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late LoginRequestModel requestModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestModel = LoginRequestModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 165, 165, 165),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => !value!.contains("@")
                    ? "Please enter correct email address!"
                    : null,
                decoration: const InputDecoration(hintText: 'Email'),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This field cannot be left blank';
                  }
                  return null;
                },
                decoration: InputDecoration(hintText: 'Password'),
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
                    );
                  }

                  // LoginController().fetchLogin(requestModel).then((value) {
                  //   print(requestModel.toJson());
                  //   if (value.token!.isNotEmpty) {
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       SnackBar(
                  //         content: Text("Login Succesfuled"),
                  //         duration: Duration(milliseconds: 300),
                  //       ),
                  //     );

                  //     Future.delayed(
                  //       Duration(seconds: 1),
                  //       () {
                  //         Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //               builder: (context) => ParticipantsPage(),
                  //             ));
                  //       },
                  //     );
                  //   } else {
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       SnackBar(
                  //         content: Text("Incremendfdfdfdfted"),
                  //         duration: Duration(milliseconds: 300),
                  //       ),
                  //     );
                  //   }
                  // });
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
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
