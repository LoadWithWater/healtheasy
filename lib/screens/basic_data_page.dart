import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'summary_screen1.dart';  // 요약 화면 임포트

class BasicDataPage extends StatefulWidget {
  @override
  _BasicDataFormState createState() => _BasicDataFormState();
}

class _BasicDataFormState extends State<BasicDataPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _saveDataAndNavigate(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        DocumentReference docRef =
        await _firestore.collection('BasicHealthDataRecords').add({
          'age': _ageController.text,
          'gender': _genderController.text,
          'height': _heightController.text,
          'weight': _weightController.text,
          'timestamp': FieldValue.serverTimestamp(),
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SummaryScreen1(documentId1: docRef.id),
          ),
        );
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('데이터 저장에 실패했습니다: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('기본 건강 정보 입력'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _ageController,
              decoration: InputDecoration(labelText: '나이'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '나이를 입력하세요';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _genderController,
              decoration: InputDecoration(labelText: '성별'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '성별을 입력하세요';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _heightController,
              decoration: InputDecoration(labelText: '키'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '키를 입력하세요';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _weightController,
              decoration: InputDecoration(labelText: '체중'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '체중을 입력하세요';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () => _saveDataAndNavigate(context),
              child: Text('전송'),
            ),
          ],
        ),
      ),
    );
  }
}