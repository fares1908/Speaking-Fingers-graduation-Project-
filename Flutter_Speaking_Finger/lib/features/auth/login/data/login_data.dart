

import 'package:soh/core/class/crud.dart';

import '../../../../core/class/app_link.dart';

class LoginData{
  Crud crud;
  LoginData(this.crud);
  loginData(String email, String password ) async{
    var response =await  crud.postData(AppLink.login,{
      "email" : email,
      "password" : password,

    });
    return response.fold((l) => l, (r) => r);
  }
}