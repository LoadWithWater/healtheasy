import 'package:flutter/material.dart';
import 'basic_data_page.dart';
import 'measureing_page.dart';
import 'monitoring_page.dart';
import 'telemedicine_page.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  CustomBottomNavBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: Colors.blueAccent, // 네비게이션 바 배경 색상 설정
      selectedItemColor: Colors.red, // 선택된 항목의 색상
      unselectedItemColor: Colors.grey, // 선택되지 않은 항목의 색상
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          label: '건강 정보 입력',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.monitor_heart),
          label: '건강 정보 측정',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.health_and_safety),
          label: '건강 모니터링',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_hospital),
          label: '비대면 진료',
        ),
      ],
    );
  }
}