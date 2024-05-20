import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:soh/core/theming/spacing.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';

class OnBoardingScreen2 extends StatelessWidget {
  const  OnBoardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
              padding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/svg/logo.svg',
                  height: 30,
                    width: 30,
                  ),
                  verticalSpace(12),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(

                          color: Colors
                              .black, // Choose the color of the underline
                          width: 1.0, // Adjust the thickness as needed
                        ),
                      ),
                    ),
                    child: const Text(
                      'Speaking Fingers',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  verticalSpace(12),
                  Text(
                      'Professional application to \n convert sign language to\n text & record',
                      style: TextStyles.font13BlackRegular
                          .copyWith(fontSize: 16)),
                  Image.asset('assets/images/onboarding2.png',
                      height: 304.h, width: double.infinity
                  ),
                  Center(
                    child: Text(
                      'convert sign language\nto text & record',
                      style: TextStyles.font28BlackRegular,
                      textAlign: TextAlign.center,
                    ),
                  )
                  ]
              ),
            ),
          ],
        ),
      ),
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