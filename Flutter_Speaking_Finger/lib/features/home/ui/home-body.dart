import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:soh/core/theming/colors.dart';

import '../../../core/theming/spacing.dart';
import '../../../core/theming/text_styles.dart';
import '../logic/home_screenbody_controller.dart';


class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({Key? key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeScreenBodyControllerImpl());

    return GetBuilder<HomeScreenBodyControllerImpl>(
      builder: (controller) {
        return Scaffold(
          bottomNavigationBar: SizedBox(
            height: 120,
            child: BottomNavigationBar(
              onTap: (value) => controller.changePage(value),
              currentIndex: controller.currentPage,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    IconlyLight.home,
                    size: 25.sp,
                  ),
                  label: '',
                  activeIcon: Column(
                    children: [
                      Icon(
                        IconlyLight.home,
                        size: 23.sp,
                        color: AppColors.themeColor,
                      ),
                      verticalSpace(4),
                      Text(
                        'Home',
                        style: TextStyles.font14SemiBold.copyWith(
                          color: AppColors.themeColor,
                        ),
                      )
                    ],
                  ),
                ),
                BottomNavigationBarItem(
                  icon: CircleAvatar(
                    backgroundColor: AppColors.themeColor.withOpacity(.2),
                    radius: 34,
                    child: CircleAvatar(
                      radius: 29,
                      backgroundColor: AppColors.themeColor,
                      child: Icon(
                        IconlyLight.camera,
                        color: Colors.white,
                        size: 30.sp,
                      ),
                    ),
                  ),
                  label: ''
                  // Omit label if you don't want text below the icon
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    IconlyLight.profile,
                    size: 23.sp,
                  ),
                  label: '',
                  activeIcon: Column(
                    children: [
                      Icon(
                        IconlyLight.profile,
                        size: 23.sp,
                        color: AppColors.themeColor,
                      ),
                      verticalSpace(4),
                      Text(
                        'Profile',
                        style: TextStyles.font14SemiBold.copyWith(
                          color: AppColors.themeColor,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: controller.listPage.elementAt(controller.currentPage),
        );
      },
    );
  }
}

