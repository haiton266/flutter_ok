import 'package:flutter/material.dart';
import 'ChangePasswordModal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple[50], // Màu tím nhạt
      child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ProfileState(),
            Positioned(
              top: 70,
              child: CircleAvatar(
                radius: 50, // Đường kính của ảnh đại diện
                backgroundImage: AssetImage('assets/images/anh3.jpg'), // Đường dẫn đến ảnh đại diện
              ),
            ),
          ]
      ),
    );
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
      backgroundColor: Colors.purple[100],
      body: Center(
        child: Container(
          height: 376.0,
          width: 300.0, // Thêm chấm động sau số để chỉ ra đây là kiểu double
          padding: EdgeInsets.all(41.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center, // Sửa thành CrossAxisAlignment.center để canh giữa
            children: <Widget>[
              Center(
                child: Column(
                  children: [
                    Text(
                      '$username',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0, // Thêm chấm động sau số để chỉ ra đây là kiểu double
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Đã upload 120 files'),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 41,
                width: 200,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2), // Thêm padding bên trong Container
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text('Email:', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('$email'),
                  ]
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 41,
                width: 200,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2), // Thêm padding bên trong Container
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Số điện thoại:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('$phoneNumber'),
                    ]
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 41,
                width: 200,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2), // Thêm padding bên trong Container
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Địa chỉ: ', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('$address'),
                    ]
                ),
              ),
              SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ChangePasswordModal();
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side:
                        BorderSide(color: Colors.purple, width: 2.0),
                      ),
                      primary: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      minimumSize: Size(35.0, 25.0),
                    ),
                    child: Text(
                      'Đổi mật khẩu',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _showLogoutConfirmation(context);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side:
                        BorderSide(color: Colors.purple, width: 2.0),
                      ),
                      primary: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      minimumSize: Size(35.0, 25.0),
                    ),
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
