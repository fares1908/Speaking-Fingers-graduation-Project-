import 'package:flutter/material.dart';

import '../../../../core/theming/text_styles.dart';
class CustomAppBarHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: AppBarClipper(),
      child: Container(
        height: 180,
        color: Colors.lightBlue.shade300,
        child:  SafeArea(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: [
                        Text(
                          'Introductory Videos',
                          style: TextStyles.font20WhiteSemiBold.copyWith(
                              color: Colors.black, fontSize: 20),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class AppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 30,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}