import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soh/core/theming/spacing.dart';

import '../../../../core/theming/text_styles.dart';

class CustomButtonNavBar extends StatelessWidget {
  const CustomButtonNavBar({
    super.key,
    this.onPressed,
    required this.iconData,
    this.colorItemSelected, required this.title,
  });
  final void Function()? onPressed;
  final IconData iconData;
  final String title;
  final Color? colorItemSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          onPressed: onPressed,
          child: Icon(
            iconData,
             size: 23.sp,
            color: colorItemSelected,
          ),
        ),
        verticalSpace(2),
        Text(
          title,
          style: TextStyles.font14SemiBold.copyWith(
            color: colorItemSelected
          ),
        )
      ],
    );
  }
}
