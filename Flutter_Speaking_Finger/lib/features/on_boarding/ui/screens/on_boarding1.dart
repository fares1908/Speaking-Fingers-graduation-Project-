import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:soh/core/theming/text_styles.dart';

class OnBoardingScreen1 extends StatelessWidget {
  const OnBoardingScreen1({super.key});
  static const String routeName = 'onboard';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/images/Shape 1.png',
                  fit: BoxFit.fill,
                  height: 310.h,
                  width: 375.w,
                ),
                Positioned(
                  top: 0,
                  left: 180.w,
                  child: SizedBox(
                      width: 211.w,
                      height: 172.h,
                      child: Image.asset(
                        'assets/images/Sub shape 1.png',
                        fit: BoxFit.fill,
                      )),
                ),
                Positioned(
                  top: 70.h,
                  left: 19.w,
                  child: SizedBox(
                    width: 60.w,
                    height: 60.h,
                    child: Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: SvgPicture.asset('assets/svg/logo.svg'),
                    ),
                  ),
                ),
                Positioned(
                  top: 135.h,
                  left: 19.w,
                  child: SizedBox(
                    width: 231.w,
                    height: 35.h,
                    child: Container(
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
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 180.h,
                  left: 19.w,
                  child: SizedBox(
                    width: 200.w,
                    height: 85.h,
                    child: Text(
                        'Professional application to \n convert sign language to\n text & record',
                        style: TextStyles.font13BlackRegular
                            .copyWith(fontSize: 12)),
                  ),
                ),
              ],
            ),
            Image.asset('assets/images/illustration.png',
                height: 304.h, width: double.infinity),
            Text(
              'open camera and speak\nby sign language',
              style: TextStyles.font28BlackRegular,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
