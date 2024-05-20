import 'package:get/get.dart';

import '../../features/favourite/logic/favourite_controller.dart';
import 'crud.dart';


class initialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud()) ;
    Get.put(FavouriteController());
  }
}