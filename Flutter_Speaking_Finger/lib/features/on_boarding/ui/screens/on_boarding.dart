import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:soh/core/routes/AppRoute/routersName.dart';

import 'on_boarding1.dart';
import 'on_boarding2.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 8.h, right: 5.w),
        child: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            if (_currentPage < onboardingScreens.length - 1) {
              // If there are more screens, navigate to the next one
              _controller.animateToPage(_currentPage + 1,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
            } else {
              Get.toNamed(AppRouter.login);
            }
          },
          shape: const CircleBorder(),
          child: const Icon(Icons.arrow_forward_ios, color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: onboardingScreens.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 90),
                child: onboardingScreens[index],
              );
            },
          ),
          Positioned(
            bottom: 50,
            left: 40,
            child: SmoothPageIndicator(
              controller: _controller,
              count: onboardingScreens.length,
              effect: ExpandingDotsEffect(
                dotColor: Colors.blue.withOpacity(.2),
                dotHeight: 8,
                expansionFactor: 1.4,
                activeDotColor: Colors.blue,
                spacing: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final List<Widget> onboardingScreens = [
  const OnBoardingScreen1(),
  OnBoardingScreen2(),
];
