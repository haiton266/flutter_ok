import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Subject/Subject.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  final username = ''.obs;

  @override
  void onInit() {
    getUsernameFromPrefs();
    super.onInit();
  }

  Future<void> getUsernameFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString('username') ?? '';
    username.value = userName;
  }
}

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  final List<Map<String, String>> subjects = [
    {
      'code': 'giaitich',
      'text': 'Giải tích',
      'image': 'assets/images/giaitich.png'
    },
    {
      'code': 'laptrinh',
      'text': 'Lập trình',
      'image': 'assets/images/laptrinh.png'
    },
    {'code': 'dientu', 'text': 'Điện tử', 'image': 'assets/images/dientu.png'},
    {'code': 'vatly', 'text': 'Vật lý', 'image': 'assets/images/vatly.png'},
    {
      'code': 'vienthong',
      'text': 'Viễn thông',
      'image': 'assets/images/vienthong.png'
    },
    {'code': 'nhung', 'text': 'Nhúng', 'image': 'assets/images/nhung.png'}
    // Add other subjects here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Obx(() {
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 25, 10, 10),
                child: Stack(
                  children: <Widget>[
                    Image.asset('assets/images/hello.png'),
                    Positioned(
                      top: 45,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hello',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            controller.username.value,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
            const Text(
              "Các môn hiện có",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.all(10),
                crossAxisCount: 2,
                children: List.generate(subjects.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Subject(
                            subjects[index]['code']!,
                            subjects[index]['text']!,
                            subjects[index]['image']!,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            subjects[index]['image']!,
                            height: 115,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            subjects[index]['text']!,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
