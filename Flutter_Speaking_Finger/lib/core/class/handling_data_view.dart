import 'package:flutter/material.dart';
import 'package:soh/core/class/status_request.dart';
import '../theming/colors.dart';


class HandlingDataView extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  final String? errorMessage; // Optional custom error message

  const HandlingDataView({
    Key? key,
    required this.statusRequest,
    required this.widget,
    this.errorMessage, // Accept an error message
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (statusRequest) {
      case StatusRequest.loading:
        return const Center(child: CircularProgressIndicator(color: AppColors.themeColor));
      case StatusRequest.offlineFailure:
        return Center(child: Text(errorMessage ?? 'Offline Failure'));
      case StatusRequest.serverFailure:
        return Center(child: Text(errorMessage ?? 'Server Failure'));
      case StatusRequest.failure:
        return Center(child: Text(errorMessage ?? 'Generic Failure'));
      default:
        return widget;
    }
  }
}

