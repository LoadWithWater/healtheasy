import 'package:flutter/material.dart';
import 'basic_data_page.dart';
import 'measureing_page.dart';
import 'monitoring_page.dart'; // MonitoringPage 임포트
import 'telemedicine_page.dart'; // TelemedicinePage 임포트
import 'custom_bottom_navbar.dart'; // 네비게이션 바 임포트

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _selectedIndex = 0;
  PageController _pageController = PageController(); // PageController 추가

  static List<Map<String, dynamic>> _pages = [
    {'title': '건강 정보 입력', 'page': BasicDataPage(), 'color': Colors.green},
    {'title': '건강 정보 측정', 'page': MeasureingPage(), 'color': Colors.blue},
    {'title': '건강 정보\n모니터링', 'page': MonitoringPage(), 'color': Colors.orange},
    {'title': '비대면 진료', 'page': TelemedicinePage(), 'color': Colors.red},
  ];

  // 네비게이션 바에서 선택된 아이템 변경 시 호출
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index); // PageView를 변경
  }

  // 슬라이드 시 페이지 변경 이벤트 처리
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메인 메뉴'),
        centerTitle: true, // 제목 중앙 배치
        backgroundColor: Color(0xffFFA1A1),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged, // 슬라이드로 페이지가 변경될 때 호출
        children: _pages.map((pageData) {
          return Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => pageData['page']),
                );
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(350, 600), // 버튼 크기 조정
                backgroundColor: pageData['color'], // 버튼 배경색
                foregroundColor: Colors.white, // 텍스트 색상 (흰색)
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // 모서리를 둥글게
                ),
              ),
              child: Text(
                pageData['title'],
                style: TextStyle(
                  fontSize: 48, // 텍스트 크기를 크게 설정
                  fontWeight: FontWeight.bold, // 텍스트 두께 설정
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }).toList(),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
