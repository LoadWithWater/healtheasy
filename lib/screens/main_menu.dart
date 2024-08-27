import 'package:flutter/material.dart';
import 'basic_data_page.dart';
import 'measureing_page.dart';
import 'monitoring_page.dart'; // MonitoringPage 임포트
import 'telemedicine_page.dart'; // TelemedicinePage 임포트

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메인 메뉴'),
        centerTitle: true, // 제목 중앙 배치
        backgroundColor: Color(0xffFFA1A1),
      ),
      body: PageView(
        children: <Widget>[
          _buildMenuPage(context, '건강 정보 입력', BasicDataPage(), Colors.green),
          _buildMenuPage(context, '건강 정보 측정', MeasureingPage(), Colors.blue),
          _buildMenuPage(context, '건강 정보 모니터링', MonitoringPage(), Colors.orange),  // MonitoringPage 연결
          _buildMenuPage(context, '비대면 진료', TelemedicinePage(), Colors.red),  // TelemedicinePage 연결
        ],
      ),
    );
  }

  Widget _buildMenuPage(BuildContext context, String title, Widget page, Color color) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        style: ElevatedButton.styleFrom(
          minimumSize: Size(200, 60), // 버튼 크기 지정
          backgroundColor: color, // 각 버튼의 배경색
          foregroundColor: Colors.white, // 버튼 텍스트 색상 (흰색)
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // 직사각형 모양 (모서리를 조금 둥글게)
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18, // 텍스트 크기
            fontWeight: FontWeight.bold, // 텍스트 두께
          ),
        ),
      ),
    );
  }
}
