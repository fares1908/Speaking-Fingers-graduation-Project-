

import 'package:soh/core/class/crud.dart';

import '../../../../core/class/app_link.dart';

class VerifyCodeSignUpData {
  Crud crud;
  VerifyCodeSignUpData(this.crud);

  postData(String userId,String otp) async {
    var response = await crud.postData(AppLink.signUpVerify, {
      "user_id":userId,
      "otp": otp
    });
    return response.fold((l) => l, (r) => r);
  }

  resendCode(String email)async{
    var response = await crud.postData(AppLink.resendOtp, {
      "email" : email ,
    });
    return response.fold((l) => l, (r) => r);
  }

}