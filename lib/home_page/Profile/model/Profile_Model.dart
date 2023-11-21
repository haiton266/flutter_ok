import 'package:get/get.dart';

class ProfileModel {
  String email;
  String phoneNumber;
  String username;
  String address;
  String uploadedFiles;
  var manageList = [].obs;

  ProfileModel({
    this.email = '',
    this.phoneNumber = '',
    this.username = '',
    this.address = '',
    this.uploadedFiles = '',
  });
}
