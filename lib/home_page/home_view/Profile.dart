import 'package:flutter/material.dart';
import 'ChangePasswordModal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProfileState();
  }
}

class ProfileState extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfileState> {
  String email = '';
  String phoneNumber = '';
  String username = '';
  String address = '';

  Future<void> fetchUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email') ?? '';
      phoneNumber = prefs.getString('phone') ?? '';
      username = prefs.getString('username') ?? '';
      address = prefs.getString('address') ?? '';
    });
  }

  void _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    prefs.remove('username');
    prefs.remove('address');
    prefs.remove('phone');
    prefs.remove('id');
    prefs.remove('token');

    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> _showLogoutConfirmation(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _logout(context);
              },
              child: Text('Logout'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Email: $email'),
            Text('Phone Number: $phoneNumber'),
            Text('Username: $username'),
            Text('Address: $address'),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ChangePasswordModal();
                  },
                );
              },
              child: Text('Change Password'),
            ),
            ElevatedButton(
              onPressed: () {
                _showLogoutConfirmation(context);
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
