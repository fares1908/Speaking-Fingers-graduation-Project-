import 'package:flutter/material.dart';
import 'package:soh/core/theming/colors.dart';
import 'package:soh/features/camera/ui/scan_screen.dart';

import 'image_from_gallery.dart';
import 'media_pip.dart';

// Assuming ScanScreen class remains unchanged

class TabBarTopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Total number of tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,

          title: const Text('Top Tab Bar Example'),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.browse_gallery_outlined,
                color: AppColors.themeColor,

                )

              ),
              Tab(
                icon: Icon(Icons.camera,color: AppColors.themeColor,

                )
              ),
              // Tab(
              //     icon: Icon(Icons.perm_media_outlined,color: AppColors.themeColor,
              //
              //     )
              // ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ImagePickScreen(),
             // ScanScreen(), // Your ScanScreen as the second tab
            MediaPip(),
         ],
        ),
      ),
    );
  }
}
