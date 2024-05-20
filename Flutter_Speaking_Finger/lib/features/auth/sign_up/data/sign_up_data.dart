

import 'package:soh/core/class/crud.dart';

import '../../../../core/class/app_link.dart';

class SignUpData{
  Crud crud;
  SignUpData(this.crud);
  registerData(String email, String password ,String name) async{
    var response =await  crud.postData(AppLink.signUp,{
      "email" : email,
      "password" : password,
      "name" : name
    });
    return response.fold((l) => l, (r) => r);
  }
}