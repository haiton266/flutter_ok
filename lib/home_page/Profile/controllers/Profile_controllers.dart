import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/home_page/Profile/model/Profile_Model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  bool isLoading = true;
  final ProfileModel profileModel = ProfileModel();

  @override
  void onInit() {
    fetchUserData();
    super.onInit();
  }

  Future<void> fetchUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      profileModel.email = prefs.getString('email') ?? '';
      profileModel.phoneNumber = prefs.getString('phone') ?? '';
      profileModel.username = prefs.getString('username') ?? '';
      profileModel.address = prefs.getString('address') ?? '';

      final response = await http
          .get(Uri.parse('https://haiton26062.pythonanywhere.com/image/all'));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var filteredList = data
            .where((x) => x['username'] == prefs.getString('username'))
            .toList();
        profileModel.uploadedFiles = 'Đã upload ${filteredList.length} files';
        isLoading = false;
        profileModel.manageList.assignAll(filteredList);
        update();
      } else {
        print('Error GET');
        isLoading = false;
        update();
      }
    } catch (e) {
      print('Error fetching user data: $e');
      isLoading = false;
      update();
    }
  }

  void showLogoutConfirmation() {
    Get.defaultDialog(
      title: 'Confirm Logout',
      content: Text('Are you sure you want to logout?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            logout();
          },
          child: Text('Logout'),
        ),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    prefs.remove('username');
    prefs.remove('address');
    prefs.remove('phone');
    prefs.remove('id');
    prefs.remove('token');
    Get.offAllNamed('/login');
  }

  void navigateToFileManagement() {
    Get.toNamed('/file_management');
    // Or use Get.to() with the destination widget if additional data needs to be passed
    // Get.to(FileManagementPage());
  }

  // Other event handling functions...
}
