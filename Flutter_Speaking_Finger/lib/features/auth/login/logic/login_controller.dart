// LoginControllerImpl.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/class/my_services.dart';
import '../../../../core/class/status_request.dart';
import '../../../../core/helpers/functions/handling_data.dart';
import '../../../../core/routes/AppRoute/routersName.dart';
import '../data/login_data.dart';

abstract class LoginController extends GetxController {


}

class LoginControllerImpl extends LoginController {
  late TextEditingController email;
  StatusRequest statusRequest = StatusRequest.none;
  LoginData loginData = LoginData(Get.find());
  late TextEditingController password;
  MyServices services = Get.find();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  loginUser() async {
    const String apiUrl = 'https://youssifallam.pythonanywhere.com/api/user/login/';
    if (formState.currentState!.validate()) {
      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'email': email.text,
            'password': password.text,
          }),
        );

        final responseData = jsonDecode(utf8.decode(response.bodyBytes));

        if (response.statusCode == 200) {
          final String userEmail = responseData['user']['email'];
          final String userName = responseData['user']['name'];
          final String phone = responseData['user']['phone_number']?? '01234567890';
          final String profile_picture = responseData['user']['profile_picture'];
          final String accessToken = responseData['tokens']['access'];
          await services.sharedPreferences.setString('phone', phone);
          await services.sharedPreferences.setString('name', userName);
          // await services.sharedPreferences.setString('profile_picture', profile_picture);
          await services.sharedPreferences.setString('email', userEmail);
          await services.sharedPreferences.setString('token', accessToken);
          await services.sharedPreferences.setString('step', "2");
          print(userEmail);
          print(phone);
          print(profile_picture);
          print(accessToken);
          Get.offNamed(AppRouter.home);
          print('Login successful');
        } else {
          statusRequest = StatusRequest.serverFailure;

          if (responseData['message'] == "يرجي تفعيل البريد الالكتروني") {
            // If the message indicates email activation, navigate to the OTP screen
            // Ensure that the 'id' is correctly extracted from the response
            String userId = responseData['user'] != null ? responseData['user']['id'].toString() : 'Unknown ID';
            Get.offNamed(AppRouter.verifyCodeSignUp, arguments: {"email": email.text, "id": userId});
          } else {
            // For other errors, show the error dialog
            showErrorDialog(responseData['message'] ?? 'An unknown error occurred');
          }

          print('Failed to login. Status Code: ${response.statusCode}');
        }
      } catch (e) {
        statusRequest = StatusRequest.failure;
        print('Error occurred while trying to login: $e');
        showErrorDialog('Failed to process your request. Please try again later.');
      }
    }


  }



  void showErrorDialog(String message) {
    // Assuming you have a context available or using Get for dialog
    Get.defaultDialog(title: "Login Error", middleText: message);
  }
  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
