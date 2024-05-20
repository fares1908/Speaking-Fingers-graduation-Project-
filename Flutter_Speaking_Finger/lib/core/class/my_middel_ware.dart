import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../routes/AppRoute/routersName.dart';
import 'my_services.dart';

class MyMiddleWare extends GetMiddleware {
  @override
  int get priority => 0;

  MyServices myServices = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    final token = myServices.sharedPreferences.getString('token');
    if (route == AppRouter.onBoarding) {
      // Assuming you don't want to redirect if it's the onboarding route
      return null;
    }
    if (token != null) {
      if (!JwtDecoder.isExpired(token)) {
        // Token is valid, so the user is already authenticated
        // Redirect to the home screen or dashboard, not the login screen
        return const RouteSettings(name: AppRouter.home); // Adjust 'AppRouter.home' to your home route name
      } else {
        // Token is expired, redirect to onboarding to potentially re-authenticate
        return const RouteSettings(name: AppRouter.login);
      }
    } else {
      // No token, redirect to onboarding screen
      return const RouteSettings(name: AppRouter.onBoarding);
    }
  }
}
