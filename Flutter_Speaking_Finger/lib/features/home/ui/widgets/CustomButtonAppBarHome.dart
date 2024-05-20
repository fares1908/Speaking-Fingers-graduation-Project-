import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:soh/core/theming/colors.dart';

import '../../logic/home_screenbody_controller.dart';
import 'CustomButtonNavBar.dart';


class CustomButtonAppBarHome extends StatelessWidget {
  const CustomButtonAppBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenBodyControllerImpl>(
      builder: (controller) {
        return  Container(
            color: Colors.white,
            height: 100,
            child: BottomAppBar(
              color:  Colors.white,
              shape: const CircularNotchedRectangle(),
              height: 80,
              notchMargin: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ...List.generate(
                    controller.listPage.length,
                    (index) => CustomButtonNavBar(
                      title: controller.titles[index],
                      iconData: controller.iconButton[index],
                      colorItemSelected: controller.currentPage == index
                          ?AppColors.themeColor
                          : Colors.grey[600],
                      onPressed: () {
                        controller.changePage(index);
                      },
                    ),
                  )
                ],
              ),
            ),
          );
      },
    );
  }
}

















