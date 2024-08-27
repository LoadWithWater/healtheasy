import 'package:flutter/material.dart';
import '/screens/home_page.dart';  // 홈 페이지로 이동하기 위해 임포트

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 3), () {});  // 3초 동안 로딩 화면 보여줌
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),  // 로딩 후 홈 페이지로 이동
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/HealthEasy.png'),  // 로딩 이미지
      ),
    );
  }
}
