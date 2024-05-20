import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

import '../../core/class/my_services.dart';
import '../../core/routes/AppRoute/routersName.dart';
import '../../core/theming/text_styles.dart';
import '../auth/widgets/custom_matrialbutton.dart';
import '../home/ui/user_screen.dart';

class UpdateUserScreen extends StatefulWidget {
  const UpdateUserScreen({super.key});

  @override
  _UpdateUserScreenState createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _mobilePasswordController = TextEditingController();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  File? _profilePicture;
  MyServices services = Get.find();
  String? profileImageUrl;

  @override
  void initState() {
    super.initState();
    _initUserInfo();
  }

  void _initUserInfo() {
    profileImageUrl =
    'https://youssifallam.pythonanywhere.com${services.sharedPreferences.getString('profile_picture') ?? '/media/default.jpg'}';
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _profilePicture = File(pickedFile.path);
        profileImageUrl = null;
      }
    });
  }

  Future<void> _updateUser() async {
    if (_formKey.currentState?.validate() ?? false) {
      final token = services.sharedPreferences.getString('token') ?? '';

      final request = http.MultipartRequest(
        'PUT',
        Uri.parse('https://youssifallam.pythonanywhere.com/api/userinfo/update/'),
      );

      request.headers['Authorization'] = 'Bearer $token';

      if (_profilePicture != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'profile_picture', _profilePicture!.path,
        ));
      }

      request.fields['phone_number'] = _mobilePasswordController.text;
      request.fields['old_password'] = _oldPasswordController.text;
      request.fields['new_password'] = _newPasswordController.text;
      request.fields['confirm_password'] = _confirmPasswordController.text;

      try {
        final response = await request.send();
        final responseBody = await response.stream.bytesToString();

        if (response.statusCode == 200) {
          Get.snackbar('Success', 'Profile updated successfully');
          _confirmPasswordController.clear();
          _newPasswordController.clear();
          _oldPasswordController.clear();
          _mobilePasswordController.clear();
        Get.offAllNamed(AppRouter.home);

        } else {
          Get.snackbar('Error', 'Failed to update profile: ${response.statusCode} - $responseBody');
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to update profile: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/profile_shape.png',
                    fit: BoxFit.fill,
                    height: 300.h,
                    width: double.infinity,
                  ),
                  Positioned(
                    top: 30,
                    left: 0,
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    child: Column(
                      children: [
                        Text(
                          'Edit Profile',
                          style: TextStyles.font20WhiteSemiBold.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 80,
                              backgroundImage: _profilePicture != null
                                  ? FileImage(_profilePicture!)
                                  : CachedNetworkImageProvider(
                                profileImageUrl ?? '',
                              ) as ImageProvider,
                              child: _profilePicture == null && profileImageUrl == null
                                  ? const CircularProgressIndicator()
                                  : null,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 24,
                                child: IconButton(
                                  icon: const Icon(Icons.camera_alt, color: Colors.black),
                                  onPressed: _pickImage,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextField(
                controller: _mobilePasswordController,
                hintText: 'Phone Number',
              ),
              CustomTextField(
                controller: _oldPasswordController,
                hintText: 'Old Password',
                obscureText: true,
              ),
              CustomTextField(
                controller: _newPasswordController,
                hintText: 'New Password',
                obscureText: true,
              ),
              CustomTextField(
                controller: _confirmPasswordController,
                hintText: 'Confirm Password',
                obscureText: true,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: CustomButtonAuth(
                  textButton: 'Update Profile',
                  onPressed: _updateUser,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: CustomButtonAuth(
                  textButton: 'Logout',
                  onPressed: () {
                    services.sharedPreferences.clear();
                    Get.offAllNamed(AppRouter.login);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const CustomTextField({
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        obscureText: obscureText,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $hintText';
          }
          return null;
        },
      ),
    );
  }
}
