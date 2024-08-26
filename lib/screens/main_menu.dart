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
      ),
      body: PageView(
        children: <Widget>[
          _buildMenuPage(context, '건강 정보 입력', BasicDataPage()),
          _buildMenuPage(context, '건강 정보 측정', MeasureingPage()),
          _buildMenuPage(context, '건강 정보 모니터링', MonitoringPage()),  // MonitoringPage 연결
          _buildMenuPage(context, '비대면 진료', TelemedicinePage()),  // TelemedicinePage 연결
        ],
      ),
    );
  }

  Widget _buildMenuPage(BuildContext context, String title, Widget page) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Text(title),
      ),
    );
  }
}
