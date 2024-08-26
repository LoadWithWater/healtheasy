import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SummaryScreen2 extends StatefulWidget {
  final String documentId2;

  SummaryScreen2({required this.documentId2});

  @override
  _SummaryScreenState2 createState() => _SummaryScreenState2();
}

class _SummaryScreenState2 extends State<SummaryScreen2> {
  String? maxPressure;
  String? minPressure;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _fetchData() async {
    try {
      DocumentSnapshot docSnapshot = await _firestore
          .collection('bloodPressureRecords')
          .doc(widget.documentId2)
          .get();
      final data = docSnapshot.data() as Map<String, dynamic>;
      setState(() {
        maxPressure = data['maxPressure'];
        minPressure = data['minPressure'];
      });
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('데이터 불러오기에 실패했습니다: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("혈압 요약"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _fetchData,
              child: Text('혈압 값 조회'),
            ),
            if (maxPressure != null && minPressure != null)
              Text('최고 혈압: $maxPressure, 최저 혈압: $minPressure'),
          ],
        ),
      ),
    );
  }
}
