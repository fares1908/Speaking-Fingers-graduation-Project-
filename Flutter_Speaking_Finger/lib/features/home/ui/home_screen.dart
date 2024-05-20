import 'package:flutter/material.dart';
import 'package:soh/features/favourite/ui/widgets/videoDetails.dart';

import '../../favourite/ui/widgets/custom_appBar_forHome.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(200.0),
          child: CustomAppBarHome(),
        ),
        body: VideoDetails());
  }
}