import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:soh/core/routes/AppRoute/routersName.dart';
import 'package:soh/features/auth/widgets/custom_matrialbutton.dart';
import '../../../core/class/my_services.dart';
import '../../auth/widgets/custom_textfield.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late Future<Map<String, dynamic>> userInfo;

  @override
  void initState() {
    super.initState();
    userInfo = fetchUserInfo();
  }

  Future<Map<String, dynamic>> fetchUserInfo() async {
    MyServices services = Get.find();
    final token = services.sharedPreferences.getString('token') ?? '';
    final response = await http.get(
      Uri.parse('https://youssifallam.pythonanywhere.com/api/userinfo/'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      services.sharedPreferences.setString('profile_picture', data['profile_picture'] ?? '/media/default.jpg');
      return data;
    } else {
      throw Exception('Failed to fetch user info: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: userInfo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image.asset(
                      'assets/images/profile_shape.png',
                      fit: BoxFit.fill,
                      height: 300.h,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: EdgeInsets.all(30.0),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: 'https://youssifallam.pythonanywhere.com${data['profile_picture'] ?? '/media/default.jpg'}',
                          width: 160,
                          height: 160,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              SizedBox(
                                width: 50,
                                height: 50,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value: downloadProgress.progress,
                                  ),
                                ),
                              ),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
                  child: Column(
                    children: [
                      ProfileInfoSection(
                        email: data['email'] ?? 'No email provided',
                        phoneNumber: data['phone_number'] ?? 'No phone number provided',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const ContentSection(),
                      CustomButtonAuth(
                        textButton: 'Edit Profile',
                        onPressed: () {
                          Get.toNamed(AppRouter.editProfile);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}

class ProfileInfoSection extends StatelessWidget {
  final String email;
  final String phoneNumber;

  const ProfileInfoSection({
    required this.email,
    required this.phoneNumber,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        ProfileInfoTile(title: 'Email', content: email),
        ProfileInfoTile(title: 'Phone Number', content: phoneNumber),
        const ProfileInfoTile(title: 'Password', content: '**********'),
      ],
    );
  }
}

class ProfileInfoTile extends StatelessWidget {
  final String title;
  final String content;

  const ProfileInfoTile({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        CustomTextField(
          valid: (p0) {},
          isNumber: false,
          readOnly: true,
          text: content,
        ),
      ],
    );
  }
}

class ContentSection extends StatelessWidget {
  const ContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.favorite_border_outlined),
      title: const Text('Favourite Videos'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Get.toNamed(AppRouter.favourite);
      },
    );
  }
}
