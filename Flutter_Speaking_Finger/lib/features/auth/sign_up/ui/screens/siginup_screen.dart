import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soh/core/class/handling_data_view.dart';
import 'package:soh/core/routes/AppRoute/routersName.dart';

import '../../../../../core/helpers/functions/valid_Input.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../widgets/custom_matrialbutton.dart';
import '../../../widgets/custom_row_auth.dart';
import '../../../widgets/custom_textfield.dart';
import '../../logic/sign_up_controller.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(SignUpControllerImpl());
    return Scaffold(
      body: GetBuilder<SignUpControllerImpl>(
          builder: (controller) => HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipPath(
                            clipper: CustomClipperPath(),
                            child: Container(
                              color: AppColors.themeColor,
                              height: 150.h,
                              width: double.infinity,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            child: SizedBox(
                                width: 120.w,
                                child: Image.asset(
                                  'assets/images/Sub shape 2.png',
                                  fit: BoxFit.fill,
                                )),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15),
                        child: Form(
                          key: controller.formState,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Get Started',
                                  style: TextStyles.font36BlackExtraBold),
                              Text(
                                'by creating a free account.',
                                style: TextStyles.font14BlackLight,
                              ),
                              SizedBox(
                                height: 100.h,
                              ),
                              CustomTextField(
                                controller: controller.name,
                                isNumber: false,
                                valid: (val) {
                                  return validInput(val!, 2, 20, 'name');
                                },
                                text: 'Full name',
                                suffixIcon: Icons.person_2_outlined,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                  controller: controller.email,
                                  isNumber: false,
                                  valid: (val) {
                                    return validInput(val!, 2, 60, 'email');
                                  },
                                  text: 'Email address',
                                  suffixIcon: Icons.email_outlined),
                              const SizedBox(
                                height: 10,
                              ),
                              // CustomTextField(
                              //   isNumber: true,
                              //   valid: (p0) {},
                              //   text: 'phone',
                              //   suffixIcon: Icons.phone_android_outlined,
                              // ),
                              // const SizedBox(
                              //   height: 10,
                              // ),
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

                              CustomButtonAuth(
                                textButton: 'Next',
                                onPressed: () {
                                  controller.goToRegister();
                                },
                                icon: Icons.arrow_forward_ios,
                              ),
                              CustomAuthRow(
                                text: 'Already a member?',
                                textButton: 'Log In',
                                onPressed: () {
                                  Get.offNamed(AppRouter.login);
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
    );
  }
}

class CustomClipperPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    final path = Path();
    path.lineTo(0, h); //layer 2
    path.quadraticBezierTo(w * 0.4, h - 120, w, h); //layer 4
    path.lineTo(w, 0); //layer 5

    return path; // Make sure to return the non-null value
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
