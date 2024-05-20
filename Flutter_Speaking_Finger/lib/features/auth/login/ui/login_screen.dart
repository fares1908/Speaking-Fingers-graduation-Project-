import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:soh/core/class/handling_data_view.dart';
import 'package:soh/core/routes/AppRoute/routersName.dart';
import 'package:soh/features/auth/login/logic/login_controller.dart';

import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../core/helpers/functions/valid_Input.dart';
import '../../widgets/custom_matrialbutton.dart';
import '../../widgets/custom_row_auth.dart';
import '../../widgets/custom_textfield.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String routeName='sing';
  @override
  Widget build(BuildContext context) {
    Get.put(LoginControllerImpl());
    return Scaffold(
      body:GetBuilder<LoginControllerImpl>(
        builder: (controller) => HandlingDataView(statusRequest: controller.statusRequest, widget: SingleChildScrollView(
          child: Form(
            key: controller.formState,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.asset(
                      'assets/images/Shape 1.png',
                      fit: BoxFit.fill,
                      height: 360.h,
                      width: double.infinity,
                    ),
                    Positioned(
                      top: 0,
                      left: 180.w,
                      child: SizedBox(
                          width: 211.w,
                          height: 222.h,
                          child: Image.asset(
                            'assets/images/Sub shape 1.png',
                            fit: BoxFit.fill,
                          )),
                    ),


                    Positioned(
                      top: 200.h,
                      left: 5.w,
                      child: SizedBox(
                        width: 500.w,
                        height: 115.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Welcome back',
                                style: TextStyles.font36BlackExtraBold
                            ),
                            Text(
                                'sign in to access your account',
                                style: TextStyles.font13BlackRegular
                                    .copyWith(fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding:
                  const EdgeInsets.only(left: 20.0, right:20,top: 80),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                          controller: controller.email,
                          isNumber: false,
                          valid: (val) {
                            return validInput(val!, 2, 60, 'email');
                          },
                          text: 'Email address',
                          suffixIcon: Icons.email_outlined),
                      const SizedBox(
                        height: 20,
                      ),

                      CustomTextField(
                        controller: controller.password,
                        isNumber: false,
                        valid: (val) {
                          return validInput(val!, 2, 20, 'Password');
                        },
                        text: 'Password',
                        suffixIcon: Icons.lock_outline,
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      Column(
                        children: [

                          CustomButtonAuth(
                            textButton: 'Next',
                            onPressed: () {
                              controller.loginUser();
                            },
                            icon: Icons.arrow_forward_ios,
                          ),
                          CustomAuthRow(
                            text: 'New member?',
                            textButton: 'Register now',
                            onPressed: () {
                              Get.offNamed(AppRouter.register);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}

