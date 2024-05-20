
import 'package:get/get.dart';
import 'package:soh/core/routes/AppRoute/routersName.dart';
import 'package:soh/features/auth/sign_up/ui/screens/siginup_screen.dart';
import 'package:soh/features/favourite/ui/favourite_screen.dart';
import 'package:soh/features/on_boarding/ui/screens/on_boarding1.dart';
import 'package:soh/features/update_user/user_screen.dart';

import '../../../features/auth/login/ui/login_screen.dart';
import '../../../features/auth/verfiy_code/ui/screen/verfiy_code.dart';
import '../../../features/home/ui/home-body.dart';
import '../../../features/on_boarding/ui/screens/on_boarding2.dart';
import '../../../features/splash/SplashScreean.dart';
import '../../class/my_middel_ware.dart';

List<GetPage<dynamic>> ?routes= [
  GetPage(
      name: '/',
      page: () => const SplashScreen(),
      // const OnBoarding(),
      middlewares: [MyMiddleWare()]),
  GetPage(name: AppRouter.splashScreen, page: () => const SplashScreen()),
  GetPage(name: AppRouter.onBoarding1, page: () => const OnBoardingScreen1()),
  GetPage(name: AppRouter.onBoarding2, page: () => const OnBoardingScreen2()),
  GetPage(name: AppRouter.login, page: () => const LoginScreen()),
  GetPage(name: AppRouter.register, page: () => const SignupScreen()),
  GetPage(
      name: AppRouter.verifyCodeSignUp, page: () => const VerifyCodeSignUp()),
  GetPage(name: AppRouter.home, page: () => const HomeScreenBody()),
  GetPage(name: AppRouter.favourite, page: () => FavoriteScreen()),
  GetPage(name: AppRouter.editProfile, page: () => const UpdateUserScreen()),
];