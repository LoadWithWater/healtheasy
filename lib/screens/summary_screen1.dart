import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SummaryScreen1 extends StatefulWidget {
  final String documentId1;

  SummaryScreen1({required this.documentId1});

  @override
  _SummaryScreenState1 createState() => _SummaryScreenState1();
}

class _SummaryScreenState1 extends State<SummaryScreen1> {
  String? age;
  String? gender;
  String? height;
  String? weight;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _fetchData() async {
    try {
      DocumentSnapshot docSnapshot = await _firestore
          .collection('BasicHealthDataRecords')
          .doc(widget.documentId1)
          .get();
      final data = docSnapshot.data() as Map<String, dynamic>;
      setState(() {
        age = data['age'];
        gender = data['gender'];
        height = data['height'];
        weight = data['weight'];
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
        title: Text("기본 건강 정보 요약"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _fetchData,
              child: Text('기본 건강 정보 조회'),
            ),
            if (age != null &&
                gender != null &&
                height != null &&
                weight != null)
              Text('나이: $age\n성별: $gender\n키: $height\n체중: $weight'),
          ],
        ),
      ),
    );
  }
}
