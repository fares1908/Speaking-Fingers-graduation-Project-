/*
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'core/class/initial_binding.dart';
import 'core/class/my_services.dart';
import 'core/routes/AppRoute/routes.dart';
List<CameraDescription> cameras = [];
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  try {
    await initialServices();
    runApp(const MyApp());
  } catch (e) {
    // Handle initialization error
    print('Initialization error: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (BuildContext c, child) => GetMaterialApp(
        title: 'Speakers fingers',
        initialBinding: initialBinding(),
        getPages: routes,
        theme: ThemeData(
          useMaterial3: false, scaffoldBackgroundColor: Colors.white,
          fontFamily:'Mulish',
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
*/